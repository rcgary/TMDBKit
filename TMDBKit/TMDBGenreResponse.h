//
//  TMDBGenreResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//
#import <Mantle/Mantle.h>

@interface TMDBGenreResponse : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSArray *genres;
@end
