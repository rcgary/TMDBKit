//
//  TMDBClient+Search.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+Search.h"
#import "TMDBPageResponse+Parse.h"
#import "TMDBMovie.h"
#import "TMDBPerson.h"
#import "TMDBUserList.h"

@implementation TMDBClient (Search)

- (RACSignal*)searchPath:(NSString*)path withQuery:(NSString*)query class:(Class)resultClass
{
    path = [NSString stringWithFormat:@"search/%@",path];
    NSDictionary *parameters = NSDictionaryOfVariableBindings(query);
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:resultClass];
            }];
}

- (RACSignal*)searchListWithQuery:(NSString*)query
{
    return [self searchPath:@"list" withQuery:query class:TMDBUserList.class];
}

- (RACSignal*)searchPersonWithQuery:(NSString*)query
{
    return [self searchPath:@"person" withQuery:query class:TMDBMovie.class];
}

- (RACSignal*)searchMoviesWithQuery:(NSString*)query
{
    return [self searchPath:@"movie" withQuery:query class:TMDBMovie.class];
}
@end
