//
//  TMDBClient.h
//  TMDBKit
//
//  Created by Chao Ruan on 16/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>
#import <Mantle/Mantle.h>

@interface TMDBClient : AFHTTPRequestOperationManager

+ (instancetype)clientWIthAPIKey:(NSString*)apiKey;
/**
 *  Get call for key sotne api, the reuslt will be cached, the cached key will be
 *  string of class name + URLString
 */
- (RACSignal *)GET:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)PUT:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)POST:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)DELETE:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters pageing:(BOOL)pageing;
- (RACSignal *)enqueueRequest:(NSURLRequest *)request fetchAllPages:(BOOL)fetchAllPages;
- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass fetchAllPages:(BOOL)fetchAllPages;
@end
