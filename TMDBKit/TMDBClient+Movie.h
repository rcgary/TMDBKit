//
//  TMDBClient+Movie.h
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"

@interface TMDBClient (Movie)

- (RACSignal*)movieWithID:(NSString*)ID;
- (RACSignal*)similarMoviesFromMovieID:(NSString*)ID;
- (RACSignal*)latestMovie;
- (RACSignal*)nowPlayingMovies;
- (RACSignal*)popularMovies;
- (RACSignal*)topRatedMovies;
- (RACSignal*)upcomingMovies;
@end
