//
//  TMDBClient+Authentication.h
//  TMDBKit
//
//  Created by Chao Ruan on 29/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"

@interface TMDBClient (Authentication)

+ (RACSignal*)loginAsGusestWithClient:(TMDBClient*)client;
+ (RACSignal*)loginWithUsername:(NSString*)username password:(NSString*)password client:(TMDBClient*)client;
+ (RACSignal *)authenticatedClientWithSavedCredentials;
@end
