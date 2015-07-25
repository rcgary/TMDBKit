//
//  TMDBPageResponseSpecSpec.m
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright 2015 Chao Ruan. All rights reserved.
//


#import "TMDBTestHelper.h"

SpecBegin(TMDBPageResponseSpec)

describe(@"TMDBPageResponseSpec", ^{
  NSDictionary *representation = [TMDBTestHelper jsonDictonaryFromClass:TMDBPageResponse.class];
  __block NSError*error;
  
  beforeEach(^{
    error = nil;
  });
  
  it(@"should be from an external representation", ^{
    TMDBPageResponse *response = [MTLJSONAdapter modelOfClass:TMDBPageResponse.class fromJSONDictionary:representation error:&error];
    expect(error).to.beNil();
    expect(response).notTo.beNil();
    expect(response.page).equal(1);
    expect(response.objects.count).equal(20);
    expect(response.totalPages).equal(11774);
    expect(response.totalResults).equal(235468);
  });
  
});

SpecEnd
