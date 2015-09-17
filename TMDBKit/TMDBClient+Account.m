//
//  TMDBClient+Account.m
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+Account.h"
#import "TMDBUser.h"
#import "TMDBPageResponse+Parse.h"
#import "TMDBUserList.h"
#import "TMDBMovie.h"
#import "TMDBAccountStatesResponse.h"

@implementation TMDBClient (Account)

- (RACSignal*)userAccount
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"account" parameters:nil];
    return [self enqueueRequest:request resultClass:TMDBUser.class];
}

- (RACSignal*)getUserLists
{
    NSString *path = [NSString stringWithFormat:@"account/%@/lists",self.user.objectID];
    NSDictionary *parameters = @{@"sort_by":@"created_at.desc"};
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBUserList.class];
            }];
}

- (RACSignal*)getFavoriteMoviesAtPage:(NSNumber*)page
{
    NSString *path = [NSString stringWithFormat:@"account/%@/favorite/movies",self.user.objectID];
    NSDictionary *parameters = @{@"sort_by":@"created_at.desc"};
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)getRatedMovies
{
    NSString *path = [NSString stringWithFormat:@"account/%@/rated/movies",self.user.objectID];
    NSDictionary *parameters = @{@"sort_by":@"created_at.desc"};
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)getWatchlistMoviesAtPage:(NSNumber*)page
{
    NSString *path = [NSString stringWithFormat:@"account/%@/watchlist/movies",self.user.objectID];
    NSDictionary *parameters = @{@"sort_by":@"created_at.desc"};
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)updateState:(TMDBAccountStateType)state withMediaID:(NSString*)mediaID mediaType:(NSString*)type value:(BOOL)value
{
    if (![self isAuthenticated]) {
        return [RACSignal empty];
    }
    NSString *stateKey = [self stringValueForState:state];
    NSString *path = [NSString stringWithFormat:@"account/%@/%@",self.user.objectID,stateKey];
    NSDictionary *parameters = @{
                                 @"media_id":mediaID,
                                 @"media_type":type,
                                 stateKey:@(value),
                                 };
    NSURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:parameters];
    return [[self enqueueRequest:request] ignoreValues];
}

- (RACSignal *)updateFavoriteStateforMedia:(TMDBObject<TMDBMedia>*)media favorite:(BOOL)favorite
{
    NSString *type = [media isKindOfClass:TMDBMovie.class] ? @"movie" : @"tv";
    return [self updateState:TMDBAccountStateFavorite withMediaID:media.objectID mediaType:type value:favorite];
}

- (RACSignal *)updateWatchListStateforMedia:(TMDBObject<TMDBMedia>*)media watchlist:(BOOL)watchlist
{
    NSString *type = [media isKindOfClass:TMDBMovie.class] ? @"movie" : @"tv";
    return [self updateState:TMDBAccountStateWatchList withMediaID:media.objectID mediaType:type value:watchlist];
}

- (RACSignal*)updateRateForMedia:(NSString*)mediaID mediaType:(NSString*)type value:(double)rateValue
{
    if (![self isAuthenticated]) {
        return [RACSignal empty];
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@/rating",type,mediaID];
    NSNumber *value = @(rateValue);
    NSDictionary *parameters = NSDictionaryOfVariableBindings(value);
    NSURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:parameters];
    return [[self enqueueRequest:request] ignoreValues];
}

- (RACSignal*)updateRateForMedia:(TMDBObject<TMDBMedia>*)media value:(double)value
{
    NSString *type = [media isKindOfClass:TMDBMovie.class] ? @"movie" : @"tv";
    return [self updateRateForMedia:media.objectID mediaType:type value:value];
}


- (NSString*)stringValueForState:(TMDBAccountStateType)state
{
    switch (state) {
        case TMDBAccountStateFavorite:
            return @"favorite";
        case TMDBAccountStateWatchList:
            return @"watchlist";
        default:
            break;
    }
}

- (RACSignal*)accountStatesForMedia:(TMDBObject<TMDBMedia>*)media
{
    NSString *type = [media isKindOfClass:TMDBMovie.class] ? @"movie" : @"tv";
    return [self accountStatesForMediaID:media.objectID type:type];
}
- (RACSignal*)accountStatesForMediaID:(NSString*)mediaID type:(NSString*)type
{
    if (![self isAuthenticated]) {
        return [RACSignal empty];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/account_states",type,mediaID];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    return [self enqueueRequest:request resultClass:TMDBAccountStatesResponse.class] ;
}

@end
