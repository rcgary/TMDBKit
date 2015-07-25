//
//  TMDBPageResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBPageResponse.h"

@implementation TMDBPageResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{
           @"totalPages" : @"total_pages",
           @"totalResults" : @"totalResults",
            };
}
@end
