//
//  TMDBEpisode.m
//  TMDBKit
//
//  Created by Chao Ruan on 20/10/2015.
//  Copyright © 2015 Chao Ruan. All rights reserved.
//

#import "TMDBEpisode.h"

@implementation TMDBEpisode
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"stillPath": @"still_path",
              @"airDate": @"air_date",
              @"name": @"name",
              @"overview": @"overview",
              @"episodeNumber": @"episode_number",
              @"voteAverage": @"vote_average",
              @"voteCount": @"vote_count",
              }];
}
@end
