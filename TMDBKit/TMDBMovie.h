//
//  TMDBMovie.h
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"
#import "TMDBMedia.h"


@interface TMDBMovie : TMDBObject<TMDBMedia>
@property (nonatomic, assign, readonly) BOOL adult;
@property (nonatomic, copy, readonly) NSString *backdropPath;
@property (nonatomic, copy, readonly) NSArray *genreIDs;
@property (nonatomic, copy, readonly) NSArray *genres;

@property (nonatomic, copy, readonly) NSString *originalLanguage;
@property (nonatomic, copy, readonly) NSString *originalTitle;
@property (nonatomic, copy, readonly) NSString *releaseDate;
@property (nonatomic, copy, readonly) NSString *posterPath;
@property (nonatomic, assign, readonly) double popularityRate;
@property (nonatomic, assign, readonly) BOOL video;
@property (nonatomic, assign, readonly) NSInteger voteCount;
@property (nonatomic, copy, readonly) NSString *imdbID;
@property (nonatomic, copy, readonly) NSString *runtime;

@property (nonatomic, assign, readonly) double voteAverage;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;

@property (nonatomic, copy, readonly) NSArray *posters;
@property (nonatomic, copy, readonly) NSArray *backdrops;
@property (nonatomic, copy, readonly) NSArray *videoKeys;
@property (nonatomic, copy, readonly) NSArray *casts;
@property (nonatomic, copy, readonly) NSArray *crews;


- (void)updateWithImageResponse:(TMDBImageResponse*)response;
- (void)updateWithVideoResponse:(TMDBVideoResponse*)response;
- (void)updateWithCreditResponse:(TMDBCreditsResponse *)response;
@end
