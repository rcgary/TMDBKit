//
//  TMDUser.h
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBUser : TMDBObject
@property (nonatomic, copy, readonly) NSURL *avatarURL;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *iso639_1;
@property (nonatomic, copy, readonly) NSString *iso3166_1;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, assign, readonly) BOOL includeAdult;
@end
