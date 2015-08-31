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
              @"name": @"name",
              @"biography": @"biography",
              @"deathday": @"deathday",
              @"birthday": @"birthday",
              }];
}

+ (NSValueTransformer *)homePageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
