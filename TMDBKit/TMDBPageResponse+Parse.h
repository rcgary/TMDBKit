//
//  TMDBPageResponse+Parse.h
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "TMDBPageResponse.h"

@interface TMDBPageResponse (Parse)
- (RACSignal*)parseResultWithClass:(Class)class;
@end
