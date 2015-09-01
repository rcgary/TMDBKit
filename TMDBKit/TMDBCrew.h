//
//  TMDBCrew.h
//  TMDBKit
//
//  Created by Chao Ruan on 21/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBCrew : TMDBObject
@property (nonatomic, copy, readonly) NSString *department;
@property (nonatomic, copy, readonly) NSString *job;
@property (nonatomic, copy, readonly) NSString *creditID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *profilePath;
@property (nonatomic, copy, readonly) NSString *posterPath;
@end
