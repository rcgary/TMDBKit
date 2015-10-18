//
//  TMDBClient.m
//  TMDBKit
//
//  Created by Chao Ruan on 16/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"
#import "TMDBUser.h"
#import "TMDBClient+Authentication.h"

@interface TMDBClient ()
// shadow property for write acces
@property (nonatomic, copy, readwrite) NSString *sessionID;
@property (nonatomic, copy, readwrite) TMDBUser *user;

@property (nonatomic, strong)NSString *apiKey;
@end

static NSString *apikey = @"2449630792c1f2e7c806b4ab2ee826b5";
static NSString *dominURLString = @"https://api.themoviedb.org/3";

@implementation TMDBClient

+ (instancetype)clientWithAPIKey:(NSString*)apiKey
{
    TMDBClient *client = [TMDBClient clientWithBaseURL:dominURLString];
    client.apiKey = apiKey;
    return client;
}

+ (instancetype)clientWithBaseURL:(NSString *)baseURL
{
    TMDBClient *client = [[TMDBClient alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    return client;
}

+ (instancetype)client
{
   return [TMDBClient clientWithAPIKey:apikey];
}

+ (instancetype)clientWithSessionID:(NSString*)sessionID user:(TMDBUser*)user
{
    TMDBClient *client = [TMDBClient clientWithAPIKey:apikey];
    client.sessionID = sessionID;
    if (user) {
        client.user = user;
    }
    return client;
}

#pragma mark - Public Methods

- (BOOL)isAuthenticated
{
    return self.sessionID != nil;
}

- (void)updateGuestSessionID:(NSString*)sessionID
{
    self.sessionID = sessionID;
}

- (void)updateSessionID:(NSString*)sessionID
{
    self.sessionID = sessionID;
}

- (void)updateUser:(TMDBUser*)user
{
    self.user = user;
}

- (void)updateSessionID:(NSString*)sessionID user:(TMDBUser*)user
{
    self.sessionID = sessionID;
    self.user = user;
    if (!sessionID)
    {
        NSLog(@"%@",user);
    }
    
    NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:user.name
                                                               password:sessionID
                                                            persistence:NSURLCredentialPersistencePermanent];
    [NSURLCredentialStorage.sharedCredentialStorage setDefaultCredential:credential
                                                      forProtectionSpace:[self.class protectionSpace]];
    
}

+ (RACSignal*)restoreCredential
{
    NSURLCredential *credential = [NSURLCredentialStorage.sharedCredentialStorage defaultCredentialForProtectionSpace:[self protectionSpace]];
    
    if (credential == nil || !credential.hasPassword) return [RACSignal error:[NSError errorWithDomain:@"No credential" code:1001 userInfo:nil]];
    
    return [RACSignal return:credential];
}

- (RACSignal *)removeCredential
{
    if (!self.sessionID) return [RACSignal empty];
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        self.sessionID = nil;
        self.user = nil;
        
        NSDictionary *credentialsDict = [NSURLCredentialStorage.sharedCredentialStorage credentialsForProtectionSpace:self.class.protectionSpace];
        NSURLCredential *credential = [credentialsDict.objectEnumerator nextObject];
        if (credential) {
            [NSURLCredentialStorage.sharedCredentialStorage removeCredential:credential forProtectionSpace:self.class.protectionSpace];
        }
        
        [subscriber sendCompleted];
        
        // nothing to dispose
        return nil;
        
    }];
}

+ (NSURLProtectionSpace *)protectionSpace
{
    return [[NSURLProtectionSpace alloc] initWithHost:@"*.chaoruan.me"
                                                 port:80
                                             protocol:NSURLProtectionSpaceHTTP
                                                realm:nil
                                 authenticationMethod:nil];
}

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

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters
{
    return [self requestWithMethod:method path:path parameters:parameters page:nil];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters page:(NSNumber*)page
{
    NSParameterAssert(method != nil);
    
    parameters = [parameters ?: [NSDictionary dictionary] mtl_dictionaryByAddingEntriesFromDictionary:@{ @"api_key": self.apiKey}];
    if (page) {
        // If it's pageing, will pass the pageing parameter, start on first page
        parameters = [parameters mtl_dictionaryByAddingEntriesFromDictionary:@{@"page": page}];
    }
    
    if (self.isAuthenticated) {
        parameters = [parameters mtl_dictionaryByAddingEntriesFromDictionary:@{@"session_id": self.sessionID}];
    }
    NSString *urlString = [[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString];
    if ([method isEqualToString:@"POST"] && self.isAuthenticated) {
        // If it's post call we need add the api key and sessionID inside there
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"?api_key=%@&session_id=%@",self.apiKey,self.sessionID]];
    }
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                   URLString:urlString
                                                                  parameters:parameters
                                                                       error:nil];
    return request;
}

#pragma mark Request Enqueuing

- (RACSignal *)enqueueRequest:(NSURLRequest *)request
{
    RACSignal *signal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (operation.response.statusCode == 204) {
                // No change in the data.
                [subscriber sendCompleted];
                return;
            }
            
            [[RACSignal return:responseObject] subscribe:subscriber];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        [self.operationQueue addOperation:operation];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
    
    return [[signal replayLazily] setNameWithFormat:@"-enqueueRequest: %@ ", request];
}

- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass
{
    return [[self enqueueRequest:request] flattenMap:^RACStream *(id responseObject) {
        return [self parsedResponseOfClass:resultClass fromJSON:responseObject];
    }];
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
        NSRange range = [result rangeAtIndex:0];
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
            //TODO: Need update the response model
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
