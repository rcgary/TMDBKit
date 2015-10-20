//
//  TMDBSeason.h
//  TMDBKit
//
//  Created by Chao Ruan on 2/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@class TMDBEpisode;

@interface TMDBSeason : TMDBObject
@property (nonatomic, copy, readonly) NSString *posterPath;
@property (nonatomic, copy, readonly) NSString *airDate;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSArray<TMDBEpisode*> *episodes;
@property (nonatomic, assign, readonly) NSInteger episodeCount;
@property (nonatomic, assign, readonly) NSInteger seasonNumber;
@end
