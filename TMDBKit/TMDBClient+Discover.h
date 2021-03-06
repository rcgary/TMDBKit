//
//  TMDBClient+Discover.h
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"

@interface TMDBClient (Discover)

- (RACSignal*)discoverMovies;
- (RACSignal*)discoverMoviesWithParameters:(NSDictionary*)parameters;
@end
