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
#import "TMDBImageResponse.h"
@implementation TMDBClient (Movie)

- (RACSignal*)movieWithID:(NSString*)ID
{
    NSString *path = [NSString stringWithFormat:@"movie/%@",ID];
    NSString *imagePath = [NSString stringWithFormat:@"movie/%@/images",ID];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil pageing:NO];
    NSURLRequest *imageRequest = [self requestWithMethod:@"GET" path:imagePath parameters:nil pageing:NO];
    
    RACSignal *movieSignal = [self enqueueRequest:request resultClass:TMDBMovie.class fetchAllPages:NO];
    RACSignal *imageSignal = [self enqueueRequest:imageRequest resultClass:TMDBImageResponse.class fetchAllPages:NO];
    
    return [[movieSignal combineLatestWith:imageSignal] map:^id(RACTuple *tuple) {
        TMDBMovie *movie = tuple.first;
        TMDBImageResponse *imageResponse = tuple.second;
        [movie updateWithImageResponse:imageResponse];
        return movie;
    }];
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
