//
//  TMDBClient.m
//  TMDBKit
//
//  Created by Chao Ruan on 16/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"

@implementation TMDBClient
+ (instancetype)clientWithBaseURL:(NSString *)baseURL
{
    TMDBClient *client = [[TMDBClient alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
    return client;
}

#pragma mark - Public Methods

- (RACSignal *)GET:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass
{
    
    RACSignal *operationSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *operation = [self GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];

            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
                [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
    
    return [[operationSignal flattenMap:^RACStream *(id value) {
        return [[self parsedResponseOfClass:resultClass fromJSON:value] collect];
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal empty];
    }];
}

- (RACSignal *)PUT:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass
{
    RACSignal *operationSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *operation = [self PUT:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
    
    return [[operationSignal flattenMap:^RACStream *(id value) {
        return [self parsedResponseOfClass:resultClass fromJSON:value];
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal empty];
    }];
}

- (RACSignal *)POST:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass
{
    RACSignal *operationSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *operation = [self POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
    
    return [[operationSignal flattenMap:^RACStream *(id value) {
        return [self parsedResponseOfClass:resultClass fromJSON:value];
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal empty];
    }];
}

- (RACSignal *)DELETE:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass
{
    RACSignal *operationSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *operation = [self DELETE:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
    
    return [[operationSignal flattenMap:^RACStream *(id value) {
        return [self parsedResponseOfClass:resultClass fromJSON:value];
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal empty];
    }];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters pageing:(BOOL)pageing {
    NSParameterAssert(method != nil);
    
    parameters = [parameters ?: [NSDictionary dictionary] mtl_dictionaryByAddingEntriesFromDictionary:@{ @"api_key": @"2449630792c1f2e7c806b4ab2ee826b5"}];
    if (pageing) {
        // If it's pageing, will pass the pageing parameter, start on first page
        parameters = [parameters mtl_dictionaryByAddingEntriesFromDictionary:@{@"page": @1}];
    }
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                   URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                                                  parameters:parameters
                                                                       error:nil];
    return request;
}

#pragma mark Request Enqueuing

- (RACSignal *)enqueueRequest:(NSURLRequest *)request fetchAllPages:(BOOL)fetchAllPages
{
    RACSignal *signal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (operation.response.statusCode == 204) {
                // No change in the data.
                [subscriber sendCompleted];
                return;
            }
            
            RACSignal *nextPageSignal = [RACSignal empty];
            NSMutableURLRequest *nextRequest = (fetchAllPages ? [self nextPageURLFromOperation:operation] : nil);
            if (nextRequest != nil) {
                nextPageSignal = [self enqueueRequest:nextRequest fetchAllPages:YES];
            }
            
            [[[RACSignal
               return:RACTuplePack(operation.response, responseObject)]
              concat:nextPageSignal]
             subscribe:subscriber];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        [self.operationQueue addOperation:operation];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
    
    return [[signal
             replayLazily]
            setNameWithFormat:@"-enqueueRequest: %@ fetchAllPages: %i", request, (int)fetchAllPages];
}

- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass fetchAllPages:(BOOL)fetchAllPages {
    return [[[self
              enqueueRequest:request fetchAllPages:fetchAllPages]
             reduceEach:^(NSHTTPURLResponse *response, id responseObject) {
                 return [self parsedResponseOfClass:resultClass fromJSON:responseObject];
             }] concat];
}

- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass
{
    return [self enqueueRequest:request resultClass:resultClass fetchAllPages:YES];
}

- (NSMutableURLRequest *)nextPageURLFromOperation:(AFHTTPRequestOperation *)operation
{
    //TODO: Return URL
    NSMutableURLRequest *nextPageURLRequest = [operation.request mutableCopy];
    NSError *error = nil;
    NSRegularExpression *relPattern = [NSRegularExpression regularExpressionWithPattern:@"page=\\d+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSAssert(relPattern != nil, @"Error constructing regular expression pattern: %@", error);
    NSString *urlString = nextPageURLRequest.URL.absoluteString;
    NSTextCheckingResult *result = [relPattern firstMatchInString:urlString options:0 range:NSMakeRange(0, urlString.length)];
    
    if (result) {
        NSRange range = [result rangeAtIndex:1];
        NSString *string = [urlString substringWithRange:range];
        NSString *pageString = [string stringByReplacingOccurrencesOfString:@"page=" withString:@""];
        NSInteger page = pageString.integerValue + 1;
        page = page >= 1000 ? 1000 : page;
        urlString = [urlString stringByReplacingCharactersInRange:range
                                           withString:[NSString stringWithFormat:@"page=%ld",(long)page]];
        nextPageURLRequest.URL = [NSURL URLWithString:urlString];
        return nextPageURLRequest;
    }
    return nil;
}

#pragma mark - Private Methods

- (RACSignal *)parsedResponseOfClass:(Class)resultClass fromJSON:(id)responseObject
{
    return [RACSignal createSignal:^ id (id<RACSubscriber> subscriber) {
        void (^parseJSONDictionary)(NSDictionary *) = ^(NSDictionary *JSONDictionary) {
            if (resultClass == nil) {
                [subscriber sendNext:JSONDictionary];
                return;
            }
            
            NSError *error = nil;
            NSObject *parsedObject = [MTLJSONAdapter modelOfClass:resultClass fromJSONDictionary:JSONDictionary error:&error];
            if (parsedObject == nil) {
                // Don't treat "no class found" errors as real parsing failures.
                // In theory, this makes parsing code forward-compatible with
                // API additions.
                if (![error.domain isEqual:MTLJSONAdapterErrorDomain] || error.code != MTLJSONAdapterErrorNoClassFound) {
                    [subscriber sendError:error];
                }
                return;
            }
            
            //            NSAssert([parsedObject isKindOfClass:KSObject.class], @"Parsed model object is not an KSObject: %@", parsedObject);
            
            [subscriber sendNext:parsedObject];
        };
        
        if ([responseObject isKindOfClass:NSArray.class]) {
            for (NSDictionary *JSONDictionary in responseObject) {
                if (![JSONDictionary isKindOfClass:NSDictionary.class]) {
                    NSString *failureReason = [NSString stringWithFormat:NSLocalizedString(@"Invalid JSON array element: %@", @""), JSONDictionary];
                    [subscriber sendError:[self parsingErrorWithFailureReason:failureReason]];
                    return nil;
                }
                
                parseJSONDictionary(JSONDictionary);
            }
            
            [subscriber sendCompleted];
        } else if ([responseObject isKindOfClass:NSDictionary.class]) {
            parseJSONDictionary(responseObject);
            [subscriber sendCompleted];
        } else if (responseObject != nil) {
            NSString *failureReason = [NSString stringWithFormat:NSLocalizedString(@"Response wasn't an array or dictionary (%@): %@", @""), [responseObject class], responseObject];
            [subscriber sendError:[self parsingErrorWithFailureReason:failureReason]];
        }
        
        return nil;
    }];
}

- (NSError *)parsingErrorWithFailureReason:(NSString *)localizedFailureReason
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[NSLocalizedDescriptionKey] = NSLocalizedString(@"Could not parse the service response.", @"");
    
    if (localizedFailureReason != nil) {
        userInfo[NSLocalizedFailureReasonErrorKey] = localizedFailureReason;
    }
    
    // TODO: const for domain and code (internal)
    return [NSError errorWithDomain:@"TMDBClientErrorDomain" code:524 userInfo:userInfo];
}
@end
