//
//  TMDBPerson.h
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBObject.h"
@class TMDBCreditsResponse;

@interface TMDBPerson : TMDBObject
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *biography;
@property (nonatomic, copy, readonly) NSArray *alsoKnownAsNames;
@property (nonatomic, copy, readonly) NSString *birthday;
@property (nonatomic, copy, readonly) NSString *deathday;
@property (nonatomic, copy, readonly) NSString *placeOfBirth;
@property (nonatomic, copy, readonly) NSString *profilePath;
@property (nonatomic, copy, readonly) NSURL *homePageURL;
@property (nonatomic, assign, readonly) BOOL adult;
@property (nonatomic, copy, readonly) NSArray *casts;
@property (nonatomic, copy, readonly) NSArray *crews;

- (void)updateWithCreditResponse:(TMDBCreditsResponse *)response;
@end
