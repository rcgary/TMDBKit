//
//  TMDBObject.m
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@implementation TMDBObject
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{
           @"objectID" : @"id",
           };
}
@end
