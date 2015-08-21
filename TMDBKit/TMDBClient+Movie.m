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
#import "TMDBVideoResponse.h"
#import "TMDBCreditsResponse.h"

NSString * const tmdb_nowPlayingMovies = @"now_playing";
NSString * const tmdb_popularMovies = @"popular";
NSString * const tmdb_topRatedMovies = @"top_rated";
NSString * const tmdb_upcomingMovies = @"upcoming";

@implementation TMDBClient (Movie)

- (RACSignal*)movieWithID:(NSString*)ID
{
    NSString *path = [NSString stringWithFormat:@"movie/%@",ID];
    NSString *imagePath = [NSString stringWithFormat:@"movie/%@/images",ID];
    NSString *videoPath = [NSString stringWithFormat:@"movie/%@/videos",ID];
    NSString *creditPath = [NSString stringWithFormat:@"movie/%@/credits",ID];
    
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    NSURLRequest *imageRequest = [self requestWithMethod:@"GET" path:imagePath parameters:nil];
    NSURLRequest *videoRequest = [self requestWithMethod:@"GET" path:videoPath parameters:nil];
    NSURLRequest *creditRequest = [self requestWithMethod:@"GET" path:creditPath parameters:nil];
    
    RACSignal *movieSignal = [self enqueueRequest:request resultClass:TMDBMovie.class ];
    RACSignal *imageSignal = [self enqueueRequest:imageRequest resultClass:TMDBImageResponse.class ];
    RACSignal *videosSignal = [self enqueueRequest:videoRequest resultClass:TMDBVideoResponse.class ];
    RACSignal *creditSignal = [self enqueueRequest:creditRequest resultClass:TMDBCreditsResponse.class ];
    
    return [[RACSignal combineLatest:@[movieSignal,imageSignal,videosSignal,creditSignal]] map:^id(RACTuple *tuple) {
        TMDBMovie *movie = tuple.first;
        TMDBImageResponse *imageResponse = tuple.second;
        TMDBVideoResponse *videoResponse = tuple.third;
        TMDBCreditsResponse *creditResponse = tuple.fifth;
        
        [movie updateWithImageResponse:imageResponse];
        [movie updateWithVideoResponse:videoResponse];
        [movie updateWithCreditResponse:creditResponse];
        return movie;
    }];
}

- (RACSignal*)fetchmoviesWithPath:(NSString*)path atPage:(NSNumber*)page
{
    path = [NSString stringWithFormat:@"movie/%@",path];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class paged:YES];
            }];
}

- (RACSignal*)similarMoviesFromMovieID:(NSString*)ID
{
    NSString *path = [NSString stringWithFormat:@"movie/%@/similar",ID];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)latestMovie
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/latest" parameters:nil];
    return [self enqueueRequest:request resultClass:TMDBMovie.class];
}

- (RACSignal*)nowPlayingMovies
{
    return [self nowPlayingMoviesAtPage:@1];
}

- (RACSignal*)nowPlayingMoviesAtPage:(NSNumber*)page
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/now_playing" parameters:nil page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)popularMovies
{
    return [self popularMoviesAtPage:@1];
}

- (RACSignal*)popularMoviesAtPage:(NSNumber*)page
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/popular" parameters:nil page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)topRatedMovies
{
    return [self topRatedMoviesAtPage:@1];
}

- (RACSignal*)topRatedMoviesAtPage:(NSNumber*)page
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/top_rated" parameters:nil page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)upcomingMovies
{
    return [self upcomingMoviesAtPage:@1];
}

- (RACSignal*)upcomingMoviesAtPage:(NSNumber*)page
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"movie/upcoming" parameters:nil page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}
@end
