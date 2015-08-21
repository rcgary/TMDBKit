//
//  TMDBCast.h
//  TMDBKit
//
//  Created by Chao Ruan on 21/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBCast : TMDBObject
@property (nonatomic, copy, readonly) NSString *character;
@property (nonatomic, assign, readonly) NSInteger castID;
@property (nonatomic, assign, readonly) NSInteger order;
@property (nonatomic, copy, readonly) NSString *creditID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *profilePath;
@end
