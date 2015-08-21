//
//  TMDBVideo.m
//  TMDBKit
//
//  Created by Chao Ruan on 18/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBVideo.h"

@implementation TMDBVideo
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"iso639_1": @"iso_639_1",
              @"name": @"name",
              @"key": @"key",
              @"site": @"site",
              @"size": @"size",
              @"type": @"type",
              }];
}
@end
