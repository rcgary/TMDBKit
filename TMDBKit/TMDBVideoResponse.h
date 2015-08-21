//
//  TMDBVideoResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 18/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TMDBVideoResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic,copy,readonly)NSArray *videos;
@end
