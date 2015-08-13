//
//  TMDBClient+Person.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+Person.h"
#import "TMDBPageResponse+Parse.h"
#import "TMDBPerson.h"

@implementation TMDBClient (Person)
- (RACSignal*)personFromID:(NSString*)personID
{
    NSString *path = [NSString stringWithFormat:@"person/%@",personID];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    return [self enqueueRequest:request resultClass:TMDBPerson.class ];
}

- (RACSignal*)popularPerson
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"person/popular" parameters:nil];
    return [[self enqueueRequest:request resultClass:TMDBPageResponse.class ]
            flattenMap:^RACStream *(TMDBPageResponse *response) {
                return [response parseResultWithClass:TMDBPerson.class];
            }];
}

- (RACSignal*)latestPerson
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"person/latest" parameters:nil];
    return [self enqueueRequest:request resultClass:TMDBPerson.class ];
}

@end
