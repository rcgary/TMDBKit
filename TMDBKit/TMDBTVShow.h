//
//  TMDBTVShow.h
//  TMDBKit
//
//  Created by Chao Ruan on 2/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@class TMDBImageResponse;
@class TMDBVideoResponse;
@class TMDBCreditsResponse;

@interface TMDBTVShow : TMDBObject
@property (nonatomic, copy, readonly) NSString *backdropPath;
@property (nonatomic, copy, readonly) NSArray *createdBy;
@property (nonatomic, copy, readonly) NSArray *genres;

@property (nonatomic, copy, readonly) NSArray *languages;
@property (nonatomic, copy, readonly) NSString *showDescription;
@property (nonatomic, copy, readonly) NSString *originalLanguage;
@property (nonatomic, copy, readonly) NSString *originalTitle;
@property (nonatomic, copy, readonly) NSString *lastAirDate;
@property (nonatomic, copy, readonly) NSString *firstAirDate;
@property (nonatomic, copy, readonly) NSString *posterPath;
@property (nonatomic, assign, readonly) double popularityRate;
@property (nonatomic, copy, readonly) NSString *showTitle;
@property (nonatomic, assign, readonly) BOOL inProduction;
@property (nonatomic, assign, readonly) double voteAverage;
@property (nonatomic, assign, readonly) NSInteger voteCount;
@property (nonatomic, assign, readonly) NSArray *episodeRunTimes;
@property (nonatomic, assign, readonly) NSArray *seasons;

@property (nonatomic, copy, readonly) NSArray *posters;
@property (nonatomic, copy, readonly) NSArray *backdrops;
@property (nonatomic, copy, readonly) NSArray *videoKeys;
@property (nonatomic, copy, readonly) NSArray *casts;
@property (nonatomic, copy, readonly) NSArray *crews;

- (void)updateWithImageResponse:(TMDBImageResponse*)response;
- (void)updateWithVideoResponse:(TMDBVideoResponse*)response;
- (void)updateWithCreditResponse:(TMDBCreditsResponse *)response;
@end
