//
//  TMDBPageResponse+Parse.m
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBPageResponse+Parse.h"

@implementation TMDBPageResponse (Parse)
- (RACSignal*)parseResultWithClass:(Class)class
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *error;
        NSArray *array = [MTLJSONAdapter modelsOfClass:class fromJSONArray:self.objects error:&error];
        if (error) {
            [subscriber sendError:error];
        } else {
            [subscriber sendNext:array];
            [subscriber sendCompleted];
        }
        return nil;
    }];
}
@end
