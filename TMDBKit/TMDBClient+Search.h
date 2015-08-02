//
//  TMDBClient+Search.h
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"

@interface TMDBClient (Search)

- (RACSignal*)searchListWithQuery:(NSString*)query;
- (RACSignal*)searchPersonWithQuery:(NSString*)query;
- (RACSignal*)searchMoviesWithQuery:(NSString*)query;

@end
