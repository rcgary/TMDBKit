//
//  TMDBVideo.h
//  TMDBKit
//
//  Created by Chao Ruan on 18/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBVideo : TMDBObject
@property (nonatomic, copy, readonly)NSString *type;
@property (nonatomic, copy, readonly)NSString *key;
@property (nonatomic, copy, readonly)NSString *site;
@property (nonatomic, copy, readonly)NSString *name;
@property (nonatomic, copy, readonly)NSString *size;
@property (nonatomic, copy, readonly) NSString *iso639_1;
@end
