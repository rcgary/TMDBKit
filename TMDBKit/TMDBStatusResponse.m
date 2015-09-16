//
//  TMDBStatusResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 16/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBStatusResponse.h"

@implementation TMDBStatusResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"statusCode" : @"status_code",
             @"statusMessage" : @"status_message",
             };
}
@end
