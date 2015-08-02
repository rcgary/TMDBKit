//
//  TMDBPerson.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBPerson.h"

@implementation TMDBPerson
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
            @{
              @"alsoKnownAsNames": @"also_known_as",
              @"placeOfBirth": @"place_of_birth",
              @"profilePath": @"profile_path",
              @"homePageURL": @"homepage",
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

+ (NSValueTransformer*)birthdayJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string, BOOL *success, NSError **error) {
        return [self.dateFormatter dateFromString:string];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError **error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer*)deathdayJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string, BOOL *success, NSError **error) {
        return [self.dateFormatter dateFromString:string];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError **error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)homePageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
