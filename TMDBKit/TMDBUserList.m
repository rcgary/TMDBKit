//
//  TMDBUserList.m
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBUserList.h"

@implementation TMDBUserList
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"listDescription": @"description",
              @"favoriteCount": @"favorite_count",
              @"itemCount": @"item_count",
              @"iso639_1": @"iso_639_1",
              @"listType": @"list_type",
              @"posterPath": @"poster_path",
              }];
}
@end
