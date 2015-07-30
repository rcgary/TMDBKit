//
//  TMDBStubber.h
//
//  Created by Chao Ruan on 23/04/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OHHTTPStubs.h"

@interface TMDBStubber : NSObject
/**
 *  Stub an URL request based on following parameters
 *
 *  @param path             the path of the stub request, eg "user/balance"
 *  @param responseFilename a stub response file name, which should be locatate in main bundle can be nil
 *  @param statusCode       status code, eg. 200, 204
 *  @param headers          headers in the response
 *  @param jsonObject       a jsonObject, can be NSArray or NSDictionary, could be nil
 */
+ (void)stubResponseWithPath:(NSString*)path
            responseFilename:(NSString*)responseFilename
                  statusCode:(int)statusCode
                     headers:(NSDictionary*)headers
                  jsonObject:(id)jsonObject;

/**
 *  Stub a request with a json file and status code 200
 *
 *  @param path             the path of the stub request, eg "user/balance"
 *  @param responseFilename a stub response file name, which should be locatate in main bundle can be nil
 */
+ (void)stubResponseWithPath:(NSString*)path responseFilename:(NSString*)responseFilename;

/**
 *  Stub a request with no content and status code 204
 *
 *  @param path the path of the stub request, eg "user/balance"
 */
+ (void)stubResponseNoContentWithPath:(NSString *)path;

/**
 *  Stub a request with a json object and status code 200
 *
 *  @param path       the path of the stub request, eg "user/balance"
 *  @param jsonObject a jsonObject, can be NSArray or NSDictionary, could be nil
 */
+ (void)stubResponseWithPath:(NSString *)path responseObject:(id)jsonObject;


/**
 *  Stub a request with a json file and status code 403
 *
 *  @param path             the path of the stub request, eg "user/balance"
 *  @param responseFilename a stub response file name, which should be locatate in main bundle can be nil
 */
+ (void)stubForbiddenResponseWithPath:(NSString*)path responseFilename:(NSString*)responseFilename;
@end
