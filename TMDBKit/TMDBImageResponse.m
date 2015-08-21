//
//  TMDBImageResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBImageResponse.h"
#import "TMDBImage.h"

@implementation TMDBImageResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return  @{
              @"backdrops":@"backdrops",
              @"posters":@"posters",
              };
}

+ (NSValueTransformer*)backdropsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TMDBImage.class];
}

+ (NSValueTransformer*)postersJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TMDBImage.class];
}
@end
