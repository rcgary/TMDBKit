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
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

@end
