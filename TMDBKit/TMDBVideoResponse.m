//
//  TMDBVideoResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 18/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBVideoResponse.h"
#import "TMDBVideo.h"

@implementation TMDBVideoResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return  @{
              @"videos":@"results",
              };
}

+ (NSValueTransformer*)videosJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TMDBVideo.class];
}

@end
