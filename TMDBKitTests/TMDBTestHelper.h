//
//  TMDBTestHelper.h
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Specta.h"
#import "TMDBKit.h"
#import "Expecta.h"
#import "TMDBStubber.h"

@interface TMDBTestHelper : NSObject

+ (NSDictionary*)jsonDictonaryFromClass:(Class)class;
+ (TMDBClient*)testClient;
@end
