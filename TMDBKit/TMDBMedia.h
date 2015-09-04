//
//  TMDBMedia.h
//  TMDBKit
//
//  Created by Chao Ruan on 4/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMDBImageResponse;
@class TMDBVideoResponse;
@class TMDBCreditsResponse;

@protocol TMDBMedia <NSObject>
@property (nonatomic, assign, readonly) double voteAverage;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSArray *posters;
@property (nonatomic, copy, readonly) NSArray *backdrops;
@property (nonatomic, copy, readonly) NSArray *videoKeys;
@property (nonatomic, copy, readonly) NSArray *casts;
@property (nonatomic, copy, readonly) NSArray *crews;
- (void)updateWithImageResponse:(TMDBImageResponse*)response;
- (void)updateWithVideoResponse:(TMDBVideoResponse*)response;
- (void)updateWithCreditResponse:(TMDBCreditsResponse *)response;
@end
