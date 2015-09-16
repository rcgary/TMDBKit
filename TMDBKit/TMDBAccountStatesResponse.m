//
//  TMDBAccountStatesResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 16/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBAccountStatesResponse.h"

@implementation TMDBAccountStatesResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"mediaID" : @"id",
             @"favorite" : @"favorite",
             @"rated" : @"rated",
             @"watchlist" : @"watchlist",
             };
}

+ (NSValueTransformer*)ratedJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError **error) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = value;
            return @([dict[@"value"] doubleValue]);
        }
        return @(0.0);
    }];
}
@end
