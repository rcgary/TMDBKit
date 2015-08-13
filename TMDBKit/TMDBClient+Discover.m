//
//  TMDBClient+Discover.m
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+Discover.h"
#import "TMDBMovie.h"
#import "TMDBPageResponse+Parse.h"

@implementation TMDBClient (Discover)

- (RACSignal*)discoverMovies
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"discover/movie" parameters:nil ];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

- (RACSignal*)discoverMoviesWithParameters:(NSDictionary*)parameters
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"discover/movie" parameters:parameters];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBMovie.class];
            }];
}

@end
