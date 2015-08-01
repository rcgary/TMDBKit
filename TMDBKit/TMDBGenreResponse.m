//
//  TMDBGenreResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBGenreResponse.h"
#import "TMDBGenre.h"

@implementation TMDBGenreResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"changeKeys" : @"change_keys",
             @"imageConfiguration" : @"images"
             };
}

+ (NSValueTransformer*)genresJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TMDBGenre.class];
}
@end
