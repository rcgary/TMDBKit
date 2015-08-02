//
//  TMDBClient+Movie.m
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+Movie.h"
#import "TMDBMovie.h"
#import "TMDBPageResponse+Parse.h"
@implementation TMDBClient (Movie)

- (RACSignal*)movieWithID:(NSString*)ID
{
    NSString *path = [NSString stringWithFormat:@"movie/%@",ID];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil pageing:NO];
    return [self enqueueRequest:request resultClass:TMDBMovie.class fetchAllPages:NO];
}

- (RACSignal*)similarMoviesFromMovieID:(NSString*)ID
{
    NSString *path = [NSString stringWithFormat:@"movie/%@/similar",ID];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil pageing:YES];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class fetchAllPages:YES]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)latestMovie
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/latest" parameters:nil pageing:NO];
    return [self enqueueRequest:request resultClass:TMDBMovie.class fetchAllPages:NO];
}

- (RACSignal*)nowPlayingMovies
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/now_playing" parameters:nil pageing:YES];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class fetchAllPages:YES]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)popularMovies
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/popular" parameters:nil pageing:YES];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class fetchAllPages:YES]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)topRatedMovies
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/top_rated" parameters:nil pageing:YES];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class fetchAllPages:YES]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)upcomingMovies
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/upcoming" parameters:nil pageing:YES];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class fetchAllPages:YES]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}
@end
