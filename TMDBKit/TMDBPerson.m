//
//  TMDBPerson.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBPerson.h"
#import "TMDBCreditsResponse.h"

@interface TMDBPerson()
@property (nonatomic, copy) NSArray *casts;
@property (nonatomic, copy) NSArray *crews;
@end

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

- (void)updateWithCreditResponse:(TMDBCreditsResponse *)response
{
    self.crews = response.crews;
    self.casts = response.casts;
}
@end
