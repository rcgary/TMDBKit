//
//  TMDBStatusResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 16/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//
#import <Mantle/Mantle.h>

@interface TMDBStatusResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic, assign, readonly) NSInteger statusCode;
@property (nonatomic, copy, readonly) NSString *statusMessage;
@end
