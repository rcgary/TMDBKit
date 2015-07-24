//
//  TMDBImageConfiguration.h
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//


#import <Mantle/Mantle.h>
@interface TMDBImageConfiguration : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSURL *baseURL;
@property (nonatomic, copy, readonly) NSURL *secureBaseURL;
@property (nonatomic, copy, readonly) NSArray *backdropSizes;
@property (nonatomic, copy, readonly) NSArray *logoSizes;
@property (nonatomic, copy, readonly) NSArray *posterSizes;
@property (nonatomic, copy, readonly) NSArray *profileSizes;
@property (nonatomic, copy, readonly) NSArray *stillSizes;
@end
