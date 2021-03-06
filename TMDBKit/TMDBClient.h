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

@class TMDBUser;
@interface TMDBClient : AFHTTPRequestOperationManager

@property (nonatomic, getter = isAuthenticated, readonly) BOOL authenticated;
@property (nonatomic, copy, readonly) TMDBUser *user;
@property (nonatomic, copy, readonly) NSString *sessionID;

+ (instancetype)client;
+ (instancetype)clientWithSessionID:(NSString*)sessionID user:(TMDBUser*)user;
+ (instancetype)clientWithAPIKey:(NSString*)apiKey;
/**
 *  Get call for key sotne api, the reuslt will be cached, the cached key will be
 *  string of class name + URLString
 */
- (RACSignal *)GET:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)PUT:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)POST:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)DELETE:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters;
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters page:(NSNumber*)page;

- (RACSignal *)enqueueRequest:(NSURLRequest *)request;
- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass;


- (void)updateGuestSessionID:(NSString*)sessionID;
- (void)updateSessionID:(NSString*)sessionID;
- (void)updateUser:(TMDBUser*)user;

- (void)updateSessionID:(NSString*)sessionID user:(TMDBUser*)user;
- (RACSignal *)removeCredential;
+ (RACSignal *)restoreCredential;
@end
