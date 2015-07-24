//
//  TMDBConfigurationResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Mantle/Mantle.h>
@class TMDBImageConfiguration;

@interface TMDBConfigurationResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSArray *changeKeys;
@property (nonatomic, copy, readonly) TMDBImageConfiguration *imageConfiguration;
@end
