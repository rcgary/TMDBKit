//
//  TMDBMovieSpecSpec.m
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright 2015 Chao Ruan. All rights reserved.
//

#import "TMDBTestHelper.h"

SpecBegin(TMDBMovieSpec)

describe(@"TMDBMovieSpec", ^{
  NSDictionary *dict = @{
    @"adult": @NO,
    @"backdrop_path": @"/dkMD5qlogeRMiEixC4YNPUvax2T.jpg",
    @"genre_ids": @[
                  @28,
                  @12,
                  @878,
                  @53
                  ],
    @"id": @135397,
    @"original_language": @"en",
    @"original_title": @"Jurassic World",
    @"overview": @"Twenty-two years after the events of Jurassic Park, Isla Nublar now features a fully functioning dinosaur theme park, Jurassic World, as originally envisioned by John Hammond.",
    @"release_date": @"2015-06-12",
    @"poster_path": @"/uXZYawqUsChGSj54wcuBtEdUJbh.jpg",
    @"popularity": @83.059414,
    @"title": @"Jurassic World",
    @"video": @NO,
    @"vote_average": @7.0,
    @"vote_count": @1340
    };
  
    
  __block NSError*error;
  
  beforeEach(^{
    error = nil;
  });
  
  it(@"should be from an external representation", ^{
    TMDBMovie *movie = [MTLJSONAdapter modelOfClass:TMDBMovie.class fromJSONDictionary:dict error:&error];
    expect(error).to.beNil();
    expect(movie).notTo.beNil();
    expect(movie.adult).equal(NO);
    expect(movie.backdropPath).equal(@"/dkMD5qlogeRMiEixC4YNPUvax2T.jpg");
    expect(movie.genreIDs.count).equal(4);
    expect(movie.objectID).equal(135397);
    expect(movie.originalLanguage).equal(@"en");
    expect(movie.originalTitle).equal(@"Jurassic World");
    expect(movie.movieDescription).equal(@"Twenty-two years after the events of Jurassic Park, Isla Nublar now features a fully functioning dinosaur theme park, Jurassic World, as originally envisioned by John Hammond.");
    expect(movie.releaseDate).notTo.beNil();
    expect(movie.posterPath).equal(@"/uXZYawqUsChGSj54wcuBtEdUJbh.jpg");
    expect(movie.popularityRate).equal(83.059414);
    expect(movie.movieTitle).equal(@"Jurassic World");
    expect(movie.video).equal(NO);
    expect(movie.voteAverage).equal(7.0);
    expect(movie.voteCount).equal(1340);
    });
    
});

SpecEnd
