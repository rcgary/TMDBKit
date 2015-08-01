//
//  TMDBObject.h
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface TMDBObject : MTLModel<MTLJSONSerializing>
@property (nonatomic, assign, readonly)NSString *objectID;
@end
