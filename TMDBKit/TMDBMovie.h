//
//  TMDBMovie.h
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBMovie : TMDBObject
@property (nonatomic, assign, readonly) BOOL adult;
@property (nonatomic, copy, readonly) NSString *backdropPath;
@property (nonatomic, copy, readonly) NSArray *genreIDs;
@property (nonatomic, copy, readonly) NSString *originalLanguage;
@property (nonatomic, copy, readonly) NSString *movieDescription;
@property (nonatomic, copy, readonly) NSString *originalTitle;
@property (nonatomic, copy, readonly) NSDate *releaseDate;
@property (nonatomic, copy, readonly) NSString *posterPath;
@property (nonatomic, assign, readonly) double popularityRate;
@property (nonatomic, copy, readonly) NSString *movieTitle;
@property (nonatomic, assign, readonly) BOOL video;
@property (nonatomic, assign, readonly) double voteAverage;
@property (nonatomic, assign, readonly) NSInteger voteCount;
@end
