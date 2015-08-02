//
//  TMDBImage.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBImage.h"

@implementation TMDBImage
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"iso639_1": @"iso_639_1",
              @"filePath": @"file_path",
              @"voteAverage": @"vote_average",
              @"voteCount": @"vote_count",
              }];
}

@end
