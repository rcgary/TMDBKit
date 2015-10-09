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
#import "TMDBTVShow.h"

@implementation TMDBClient (Search)

- (RACSignal*)searchPath:(NSString*)path withQuery:(NSString*)query class:(Class)resultClass atPage:(NSNumber*)page
{
    path = [NSString stringWithFormat:@"search/%@",path];
    NSDictionary *parameters = NSDictionaryOfVariableBindings(query);
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:resultClass paged:YES];
            }];
}
- (RACSignal*)searchWithType:(TMDBSearchType)type withQuery:(NSString*)query atPage:(NSNumber*)page
{
    NSString *path;
    Class resultClass;
    switch (type) {
        case TMDBSearchMovie:
            path = @"movie";
            resultClass = TMDBMovie.class;
            break;
        case TMDBSearchTVShow:
            path = @"tv";
            resultClass = TMDBTVShow.class;
            break;
        case TMDBSearchPeople:
            path = @"person";
            resultClass = TMDBPerson.class;
            break;
        default:
            break;
    }
    return [self searchPath:path withQuery:query class:resultClass atPage:page];
}

- (RACSignal*)searchListWithQuery:(NSString*)query atPage:(NSNumber*)page
{
    return [self searchPath:@"tv" withQuery:query class:TMDBTVShow.class atPage:page];
}

- (RACSignal*)searchPersonWithQuery:(NSString*)query atPage:(NSNumber*)page
{
    return [self searchPath:@"person" withQuery:query class:TMDBPerson.class atPage:page];
}

- (RACSignal*)searchMoviesWithQuery:(NSString*)query atPage:(NSNumber*)page
{
    return [self searchPath:@"movie" withQuery:query class:TMDBMovie.class atPage:page];
}

- (RACSignal*)searchKeyWords
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"search/trending" parameters:nil];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class] flattenMap:^RACStream *(TMDBPageResponse *response) {
        RACSignal *movies=
         [[response parseResultWithClass:TMDBMovie.class paged:NO] map:^id(NSArray *medias) {
           return [[[medias.rac_sequence map:^id(TMDBObject<TMDBMedia> *media) {
               return media.title;
           }]take:4] array];
       }];
        
        RACSignal *tvShows= [[response parseResultWithClass:TMDBTVShow.class paged:NO] map:^id(NSArray *medias) {
            return [[[medias.rac_sequence map:^id(TMDBObject<TMDBMedia> *media) {
                return media.title;
            }]take:4] array];
        }];
        return [[movies combineLatestWith:tvShows] map:^id(RACTuple *tuple) {
            return [tuple.first arrayByAddingObjectsFromArray:tuple.second];
        }];
    }];
}
@end
