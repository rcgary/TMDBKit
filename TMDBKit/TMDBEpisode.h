//
//  TMDBEpisode.h
//  TMDBKit
//
//  Created by Chao Ruan on 20/10/2015.
//  Copyright © 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"

@interface TMDBEpisode : TMDBObject
@property (nonatomic, copy, readonly) NSString *stillPath;
@property (nonatomic, copy, readonly) NSString *airDate;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, assign, readonly) NSInteger episodeNumber;
@property (nonatomic, assign, readonly) NSInteger voteCount;
@property (nonatomic, assign, readonly) double voteAverage;
@end
