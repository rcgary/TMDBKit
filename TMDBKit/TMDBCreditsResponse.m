//
//  TMDBCreditsResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 21/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBCreditsResponse.h"
#import "TMDBCrew.h"
#import "TMDBCast.h"

@implementation TMDBCreditsResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"crews" : @"crew",
             @"casts" : @"cast",
             };
}

+ (NSValueTransformer*)crewsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TMDBCrew.class];
}

+ (NSValueTransformer*)castsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TMDBCast.class];
}

@end
