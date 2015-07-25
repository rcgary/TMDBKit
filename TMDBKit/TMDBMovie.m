//
//  TMDBMovie.m
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBMovie.h"

@implementation TMDBMovie
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
  return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
          @{
            @"backdropPath": @"backdrop_path",
            @"genreIDs": @"genre_ids",
            @"originalLanguage": @"original_language",
            @"originalTitle": @"original_title",
            @"releaseDate": @"release_date",
            @"posterPath": @"poster_path",
            @"voteAverage": @"vote_average",
            @"voteCount": @"vote_count",
            @"movieTitle": @"title",
            @"popularityRate": @"popularity",
            @"movieDescription": @"overview",
            }];
}

+ (NSDateFormatter*)dateFormatter
{
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
  });
  return dateFormatter;
}

+ (NSValueTransformer*)releaseDateJSONTransformer
{
  return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string, BOOL *success, NSError **error) {
    return [self.dateFormatter dateFromString:string];
  } reverseBlock:^id(NSDate *date, BOOL *success, NSError **error) {
    return [self.dateFormatter stringFromDate:date];
  }];
}

@end
