//
//  TMDBImageConfiguration.m
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBImageConfiguration.h"

@implementation TMDBImageConfiguration
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{
           @"baseURL" : @"base_url",
           @"secureBaseURL" : @"secure_base_url",
           @"backdropSizes" : @"backdrop_sizes",
           @"logoSizes" : @"logo_sizes",
           @"posterSizes" : @"poster_sizes",
           @"profileSizes" : @"profile_sizes",
           @"stillSizes" : @"still_sizes",
            };
}

+ (NSValueTransformer *)baseURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)secureBaseURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
