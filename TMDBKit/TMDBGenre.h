//
//  TMDBGenres.h
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBGenre : TMDBObject
@property (nonatomic, copy, readonly) NSString *name;
@end
