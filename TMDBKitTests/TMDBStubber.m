//
//  HKTStuber.m
//  HUBKit
//
//  Created by Chao Ruan on 23/04/2015.
//  Copyright (c) 2015 Movideo. All rights reserved.
//

#import "TMDBStubber.h"
#import "Mantle/Mantle.h"

@implementation TMDBStubber

+ (void)stubResponseWithPath:(NSString*)path responseFilename:(NSString*)responseFilename statusCode:(int)statusCode headers:(NSDictionary*)headers jsonObject:(id)jsonObject
{
    if (responseFilename != nil) {
        headers = [headers mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                         @"Content-Type": @"application/json",
                                                                         }];
    }
    [OHHTTPStubs  stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
      
        return [request.URL.path isEqual:[@"/3/" stringByAppendingString:path]];
        
    }withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request){
        
        if (responseFilename) {
            NSString* fixture = OHPathForFile(responseFilename, TMDBStubber.class);
            return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                    statusCode:statusCode
                                                       headers:headers];
            
        }
        else if (jsonObject)
        {
            return [OHHTTPStubsResponse responseWithJSONObject:jsonObject
                                                    statusCode:statusCode
                                                       headers:headers];
        }
        else {
            return [OHHTTPStubsResponse responseWithData:[NSData data]
                                              statusCode:statusCode
                                                 headers:headers];
        }
    }]; 
}

+ (void)stubResponseWithPath:(NSString*)path responseFilename:(NSString*)responseFilename
{
    [TMDBStubber stubResponseWithPath:path
                    responseFilename:responseFilename
                          statusCode:200
                             headers:@{}
                          jsonObject:nil];
}

+ (void)stubResponseNoContentWithPath:(NSString *)path
{
    [TMDBStubber stubResponseWithPath:path
                    responseFilename:nil
                          statusCode:204
                             headers:@{}
                          jsonObject:nil];
}

+ (void)stubResponseWithPath:(NSString *)path responseObject:(id)jsonObject
{
    [TMDBStubber stubResponseWithPath:path
                    responseFilename:nil
                          statusCode:200
                             headers:@{}
                          jsonObject:jsonObject];
}

+ (void)stubForbiddenResponseWithPath:(NSString*)path responseFilename:(NSString*)responseFilename
{
    [TMDBStubber stubResponseWithPath:path
                    responseFilename:responseFilename
                          statusCode:403
                             headers:@{}
                          jsonObject:nil];
}

@end
