//
//  TMDBCast.m
//  TMDBKit
//
//  Created by Chao Ruan on 21/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBCast.h"

@implementation TMDBCast
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"castID": @"cast_id",
              @"name": @"name",
              @"character": @"character",
              @"creditID": @"credit_id",
              @"order": @"order",
              @"profilePath": @"profile_path",
              }];
}
@end
