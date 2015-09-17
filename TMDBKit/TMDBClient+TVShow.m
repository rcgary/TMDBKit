//
//  TMDBClient+TVShow.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+TVShow.h"
#import "TMDBTVShow.h"
#import "TMDBPageResponse+Parse.h"
#import "TMDBImageResponse.h"
#import "TMDBVideoResponse.h"
#import "TMDBCreditsResponse.h"
#import "TMDBAccountStatesResponse.h"
NSString * const tmdb_onTheAirShows = @"on_the_air";
NSString * const tmdb_popularShows = @"popular";
NSString * const tmdb_topRatedShows = @"top_rated";
NSString * const tmdb_airingToday = @"airing_today";
@implementation TMDBClient (TVShow)

- (RACSignal*)tvShowWithID:(NSString*)ID
{
    NSString *path = [NSString stringWithFormat:@"tv/%@",ID];
    NSString *imagePath = [NSString stringWithFormat:@"tv/%@/images",ID];
    NSString *videoPath = [NSString stringWithFormat:@"tv/%@/videos",ID];
    NSString *creditPath = [NSString stringWithFormat:@"tv/%@/credits",ID];
    
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    NSURLRequest *imageRequest = [self requestWithMethod:@"GET" path:imagePath parameters:nil];
    NSURLRequest *videoRequest = [self requestWithMethod:@"GET" path:videoPath parameters:nil];
    NSURLRequest *creditRequest = [self requestWithMethod:@"GET" path:creditPath parameters:nil];
    
    RACSignal *tvShowsSignal = [self enqueueRequest:request resultClass:TMDBTVShow.class ];
    RACSignal *imageSignal = [self enqueueRequest:imageRequest resultClass:TMDBImageResponse.class ];
    RACSignal *videosSignal = [self enqueueRequest:videoRequest resultClass:TMDBVideoResponse.class ];
    RACSignal *creditSignal = [self enqueueRequest:creditRequest resultClass:TMDBCreditsResponse.class ];
    
    return [[RACSignal combineLatest:@[tvShowsSignal,imageSignal,videosSignal,creditSignal]] map:^id(RACTuple *tuple) {
        TMDBTVShow *show = tuple.first;
        TMDBImageResponse *imageResponse = tuple.second;
        TMDBVideoResponse *videoResponse = tuple.third;
        TMDBCreditsResponse *creditResponse = tuple.fourth;
        
        [show updateWithImageResponse:imageResponse];
        [show updateWithVideoResponse:videoResponse];
        [show updateWithCreditResponse:creditResponse];
        return show;
    }];
}
- (RACSignal*)fetchTVShowsWithPath:(NSString*)path atPage:(NSNumber*)page
{
    path = [NSString stringWithFormat:@"tv/%@",path];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil page:page];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBTVShow.class paged:page != nil];
            }];
}

- (RACSignal*)latestTVShows
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"tv/latest" parameters:nil];
    return [self enqueueRequest:request resultClass:TMDBTVShow.class];
}

- (RACSignal*)onAirTVShows
{
    return [self fetchTVShowsWithPath:tmdb_onTheAirShows atPage:nil];
}

- (RACSignal*)onAirTVShowsAtPage:(NSNumber*)page
{
    return [self fetchTVShowsWithPath:tmdb_onTheAirShows atPage:page];
}

- (RACSignal*)airingTodayTVShows
{
    
    return [self fetchTVShowsWithPath:tmdb_airingToday atPage:nil];
}

- (RACSignal*)airingTodayTVShowsAtPage:(NSNumber*)page
{
    return [self fetchTVShowsWithPath:tmdb_airingToday atPage:page];
}

- (RACSignal*)topRatedTVShows
{
    
    return [self fetchTVShowsWithPath:tmdb_topRatedShows atPage:nil];
}

- (RACSignal*)topRatedTVShowsAtPage:(NSNumber*)page
{
    
    return [self fetchTVShowsWithPath:tmdb_topRatedShows atPage:page];
}

- (RACSignal*)popularTVShows
{
    
    return [self fetchTVShowsWithPath:tmdb_popularShows atPage:nil];
}

- (RACSignal*)popularTVShowsAtPage:(NSNumber*)page
{
    
    return [self fetchTVShowsWithPath:tmdb_popularShows atPage:page];
}

- (RACSignal*)accountStatesForShowID:(NSString*)showID
{
    if (![self isAuthenticated]) {
        return [RACSignal empty];
    }
    
    NSString *path = [NSString stringWithFormat:@"tv/%@/account_states",showID];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    return [self enqueueRequest:request resultClass:TMDBAccountStatesResponse.class] ;
}
@end
