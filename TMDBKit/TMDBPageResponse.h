//
//  TMDBPageResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
@interface TMDBPageResponse :  MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSArray *objects;
@property (nonatomic, assign, readonly) NSInteger page;
@property (nonatomic, assign, readonly) NSInteger totalPages;
@property (nonatomic, assign, readonly) NSInteger totalResults;
@end
