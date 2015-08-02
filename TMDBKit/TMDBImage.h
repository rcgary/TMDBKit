//
//  TMDBImage.h
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBImage : TMDBObject
@property (nonatomic, copy, readonly)NSString *filePath;
@property (nonatomic, assign, readonly)double aspectRatio;
@property (nonatomic, assign, readonly)double height;
@property (nonatomic, assign, readonly)double width;
@property (nonatomic, assign, readonly)double voteAverage;
@property (nonatomic, assign, readonly)NSInteger voteCount;
@property (nonatomic, copy, readonly) NSString *iso639_1;
@end
