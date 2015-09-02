//
//  TMDBSeason.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBSeason.h"

@implementation TMDBSeason
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"posterPath": @"poster_path",
              @"airDate": @"air_date",
              @"episodeCount": @"episode_count",
              @"seasonNumber": @"season_number",
              }];
}
@end
