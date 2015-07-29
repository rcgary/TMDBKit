//
//  TMDBTokenResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 29/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBTokenResponse.h"

@implementation TMDBTokenResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"token" : @"request_token",
             @"sessionID" : @"session_id"
             };
}
@end
