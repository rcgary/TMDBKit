//
//  TMDBClient.h
//  TMDBKit
//
//  Created by Chao Ruan on 16/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface TMDBClient : AFHTTPRequestOperationManager
+ (instancetype)clientWithBaseURL:(NSString *)baseURL;
/**
 *  Get call for key sotne api, the reuslt will be cached, the cached key will be
 *  string of class name + URLString
 */
- (RACSignal *)GET:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)PUT:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)POST:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
- (RACSignal *)DELETE:(NSString *)URLString parameters:(id)parameters resultClass:(Class)resultClass;
@end
