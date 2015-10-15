//
//  TMDBClient+Account.h
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"
#import "TMDBMedia.h"

typedef NS_ENUM(NSInteger, TMDBAccountStateType) {
   TMDBAccountStateFavorite,
   TMDBAccountStateWatchList,
};

@class TMDBObject;
@interface TMDBClient (Account)
- (RACSignal*)userAccount;
- (RACSignal*)getUserLists;
- (RACSignal*)getFavoriteMoviesAtPage:(NSNumber*)page;
- (RACSignal*)getFavoriteTVShowsAtPage:(NSNumber*)page;
- (RACSignal*)getRatedMovies;
- (RACSignal*)getWatchlistMoviesAtPage:(NSNumber*)page;
- (RACSignal*)getWatchlistTVShowsAtPage:(NSNumber*)page;
- (RACSignal*)updateFavoriteStateforMedia:(TMDBObject<TMDBMedia>*)media favorite:(BOOL)favorite;
- (RACSignal*)updateWatchListStateforMedia:(TMDBObject<TMDBMedia>*)media watchlist:(BOOL)watchlist;
- (RACSignal*)updateRateForMedia:(TMDBObject<TMDBMedia>*)media value:(double)value;
- (RACSignal*)accountStatesForMedia:(TMDBObject<TMDBMedia>*)media;
@end
