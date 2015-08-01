//
//  TMDBTestHelper.m
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBTestHelper.h"
#import "OHHTTPStubs.h"
@implementation TMDBTestHelper

+ (NSDictionary*)jsonDictonaryFromFileName:(NSString*)fileName
{
  fileName = [fileName stringByAppendingString:@".json"];
  NSString *path = OHPathForFile(fileName, TMDBTestHelper.class);
  NSData *contentData = [NSData dataWithContentsOfFile:path];
  NSDictionary *representation = [NSJSONSerialization JSONObjectWithData:contentData options:0 error:NULL];
  return representation;
}

+ (NSDictionary*)jsonDictonaryFromClass:(Class)class
{
  return [self jsonDictonaryFromFileName:NSStringFromClass(class)];
}


+ (TMDBClient*)testClient
{
    NSDictionary *representation = [TMDBTestHelper jsonDictonaryFromClass:TMDBUser.class];
    TMDBUser *user = [MTLJSONAdapter modelOfClass:TMDBUser.class fromJSONDictionary:representation error:nil];
    NSString *sessoinID = @"0c046bf1b29cd971babc916f39da337";
    return [TMDBClient clientWithSessionID:sessoinID user:user];
}

@end
