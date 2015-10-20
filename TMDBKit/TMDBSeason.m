//
//  TMDBSeason.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBSeason.h"
#import "TMDBEpisode.h"

@implementation TMDBSeason
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"posterPath": @"poster_path",
              @"airDate": @"air_date",
              @"episodeCount": @"episode_count",
              @"seasonNumber": @"season_number",
              @"name": @"name",
              @"overview": @"overview",
              @"episodes": @"episodes",
              }];
}

+ (NSValueTransformer*)episodesJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TMDBEpisode.class];
}
@end
