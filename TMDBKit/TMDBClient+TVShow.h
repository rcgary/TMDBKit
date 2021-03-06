//
//  TMDBClient+TVShow.h
//  TMDBKit
//
//  Created by Chao Ruan on 2/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"
extern NSString * const tmdb_onTheAirShows;
extern NSString * const tmdb_popularShows;
extern NSString * const tmdb_topRatedShows;
extern NSString * const tmdb_airingToday;

@interface TMDBClient (TVShow)
- (RACSignal*)tvShowWithID:(NSString*)ID;
- (RACSignal*)fetchTVShowsWithPath:(NSString*)path atPage:(NSNumber*)page;

- (RACSignal*)latestTVShows;
- (RACSignal*)onAirTVShows;
- (RACSignal*)onAirTVShowsAtPage:(NSNumber*)page;
- (RACSignal*)airingTodayTVShows;
- (RACSignal*)airingTodayTVShowsAtPage:(NSNumber*)page;
- (RACSignal*)topRatedTVShows;
- (RACSignal*)topRatedTVShowsAtPage:(NSNumber*)page;
- (RACSignal*)popularTVShows;
- (RACSignal*)popularTVShowsAtPage:(NSNumber*)page;
@end
