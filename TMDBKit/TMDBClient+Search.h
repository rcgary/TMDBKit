//
//  TMDBClient+Search.h
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"
typedef NS_ENUM(NSInteger, TMDBSearchType) {
    TMDBSearchMovie,
    TMDBSearchTVShow,
    TMDBSearchPeople,
};

@interface TMDBClient (Search)
- (RACSignal*)searchWithType:(TMDBSearchType)type withQuery:(NSString*)query atPage:(NSNumber*)page;
- (RACSignal*)searchListWithQuery:(NSString*)query atPage:(NSNumber*)page;
- (RACSignal*)searchPersonWithQuery:(NSString*)query atPage:(NSNumber*)page;
- (RACSignal*)searchMoviesWithQuery:(NSString*)query atPage:(NSNumber*)page;
/**
 *  Return a RACSignal which has 8 trending search keywords in NSArray
 */
- (RACSignal*)searchTrendingKeyWords;
@end
