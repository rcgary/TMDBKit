//
//  TMDBClient+Genres.m
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+Genres.h"
#import "TMDBGenre.h"
#import "TMDBGenreResponse.h"
#import "TMDBMovie.h"
#import "TMDBPageResponse+Parse.h"

@implementation TMDBClient (Genres)
- (RACSignal*)allMovieGenre
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"genre/movie/list" parameters:nil];
    return [[self enqueueRequest:request resultClass:TMDBGenreResponse.class ]
            map:^id(TMDBGenreResponse *response) {
                return response.genres;
            }];
}

- (RACSignal*)moviesFromGenre:(TMDBGenre*)genre
{
    NSString *path = [NSString stringWithFormat:@"genre/%@/movie",genre.objectID];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}
@end
