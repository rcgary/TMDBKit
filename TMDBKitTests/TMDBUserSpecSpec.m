//
//  TMDBUserSpecSpec.m
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright 2015 Chao Ruan. All rights reserved.
//

#import "TMDBTestHelper.h"


SpecBegin(TMDBUserSpec)

describe(@"TMDBUserSpec", ^{
    
  NSDictionary *representation = [TMDBTestHelper jsonDictonaryFromClass:TMDBUser.class];
  __block NSError*error;
  
  beforeEach(^{
    error = nil;
  });
  
  it(@"should be from an external representation", ^{
    TMDBUser *user = [MTLJSONAdapter modelOfClass:TMDBUser.class fromJSONDictionary:representation error:&error];
    expect(error).to.beNil();
    expect(user).notTo.beNil();
    expect(user.name).equal(@"Chao Ruan");
    expect(user.username).equal(@"chaoruan");
    expect(user.objectID).equal(6258765);
    expect(user.iso3166_1).equal(@"AU");
    expect(user.iso639_1).equal(@"en");
    expect(user.includeAdult).beTruthy();
    expect(user.avatarURL.absoluteString).equal(@"https://secure.gravatar.com/avatar/772eb26112c3297ce1204bfc4ccf5d65.jpg?s=512");
    });
    
});

SpecEnd
