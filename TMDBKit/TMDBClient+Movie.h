//
//  TMDBClient+Movie.h
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"

extern NSString * const tmdb_nowPlayingMovies;
extern NSString * const tmdb_popularMovies;
extern NSString * const tmdb_topRatedMovies;
extern NSString * const tmdb_upcomingMovies;

@interface TMDBClient (Movie)


- (RACSignal*)movieWithID:(NSString*)ID;
- (RACSignal*)similarMoviesFromMovieID:(NSString*)ID;
- (RACSignal*)latestMovie;
- (RACSignal*)nowPlayingMovies;
- (RACSignal*)nowPlayingMoviesAtPage:(NSNumber*)page;
- (RACSignal*)popularMovies;
- (RACSignal*)popularMoviesAtPage:(NSNumber*)page;
- (RACSignal*)topRatedMovies;
- (RACSignal*)topRatedMoviesAtPage:(NSNumber*)page;
- (RACSignal*)upcomingMovies;
- (RACSignal*)upcomingMoviesAtPage:(NSNumber*)page;
- (RACSignal*)accountStatesForMovieID:(NSString*)movieID;
- (RACSignal*)fetchMoviesWithPath:(NSString*)path atPage:(NSNumber*)page;
@end
