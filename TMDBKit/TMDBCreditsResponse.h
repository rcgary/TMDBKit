//
//  TMDBCreditsResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 21/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TMDBCreditsResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSArray *casts;
@property (nonatomic, copy, readonly) NSArray *crews;
@end
