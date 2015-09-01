//
//  TMDBCrew.m
//  TMDBKit
//
//  Created by Chao Ruan on 21/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBCrew.h"

@implementation TMDBCrew
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"name": @"name",
              @"job": @"job",
              @"creditID": @"credit_id",
              @"department": @"department",
              @"profilePath": @"profile_path",
              @"posterPath": @"poster_path",
              }];
}
@end
