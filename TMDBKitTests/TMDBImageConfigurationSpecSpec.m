//
//  TMDBImageConfigurationSpecSpec.m
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright 2015 Chao Ruan. All rights reserved.
//

#import "TMDBKit.h"
#import "TMDBTestHelper.h"

SpecBegin(TMDBImageConfigurationSpec)

describe(@"TMDBImageConfigurationSpec", ^{
  NSDictionary *images = @{
                           @"base_url": @"http://image.tmdb.org/t/p/",
                           @"secure_base_url": @"https://image.tmdb.org/t/p/",
                           @"backdrop_sizes": @[
                               @"w300",
                               @"w780",
                               @"w1280",
                               @"original"
                               ],
                           @"logo_sizes": @[
                               @"w45",
                               @"w92",
                               @"w154",
                               @"w185",
                               @"w300",
                               @"w500",
                               @"original"
                               ],
                           @"poster_sizes": @[
                               @"w92",
                               @"w154",
                               @"w185",
                               @"w342",
                               @"w500",
                               @"w780",
                               @"original"
                               ],
                           @"profile_sizes": @[
                               @"w45",
                               @"w185",
                               @"h632",
                               @"original"
                               ],
                           @"still_sizes": @[
                               @"w92",
                               @"w185",
                               @"w300",
                               @"original"
                               ]
                           
                           };
  __block NSError*error;
  
  beforeEach(^{
    error = nil;
  });
  
  it(@"should be from an external representation", ^{
    TMDBImageConfiguration *imageConfiguration = [MTLJSONAdapter modelOfClass:TMDBImageConfiguration.class fromJSONDictionary:images error:&error];
    expect(error).to.beNil();
    expect(imageConfiguration).notTo.beNil();
    expect(imageConfiguration.baseURL.absoluteString).equal(@"http://image.tmdb.org/t/p/");
    expect(imageConfiguration.secureBaseURL.absoluteString).equal(@"https://image.tmdb.org/t/p/");
    expect(imageConfiguration.backdropSizes.count).equal(4);
    expect(imageConfiguration.logoSizes.count).equal(7);
    expect(imageConfiguration.posterSizes.count).equal(7);
    expect(imageConfiguration.profileSizes.count).equal(4);
    expect(imageConfiguration.stillSizes.count).equal(4);
  });  

});

SpecEnd
