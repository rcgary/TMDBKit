//
//  TMDBConfigurationResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBConfigurationResponse.h"
#import "TMDBImageConfiguration.h"

@implementation TMDBConfigurationResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{
           @"changeKeys" : @"change_keys",
           @"imageConfiguration" : @"images"
            };
}

+ (NSValueTransformer*)imageConfigurationJSONTransformer
{
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:TMDBImageConfiguration.class];
}
@end
