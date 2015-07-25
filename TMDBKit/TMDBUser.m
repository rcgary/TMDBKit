//
//  TMDUser.m
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBUser.h"


@implementation TMDBUser

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
  return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
          @{
            @"iso639_1": @"iso_639_1",
            @"iso3166_1": @"iso_3166_1",
            @"includeAdult": @"include_adult",
            @"avatarURL": @"avatar",
            @"name": @"name",
            @"username": @"username",
            }];
}

+ (NSValueTransformer*)avatarURLJSONTransformer
{
  return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dict, BOOL *success, NSError **error) {
    NSString *hashCode = dict[@"gravatar"][@"hash"];
    if (hashCode.length > 0) {
      NSString *urlString = [NSString stringWithFormat:@"https://secure.gravatar.com/avatar/%@.jpg?s=512",hashCode];
      return [NSURL URLWithString:urlString];
    }
    return nil;
  }];
}
@end
