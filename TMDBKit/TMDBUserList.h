//
//  TMDBUserList.h
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBUserList : TMDBObject

@property (nonatomic, copy, readonly) NSString *listDescription;
@property (nonatomic, assign, readonly) NSInteger itemCount;
@property (nonatomic, assign, readonly) NSInteger favoriteCount;
@property (nonatomic, copy, readonly) NSString *iso639_1;
@property (nonatomic, copy, readonly) NSString *listType;
@property (nonatomic, copy, readonly) NSString *name;

@end
