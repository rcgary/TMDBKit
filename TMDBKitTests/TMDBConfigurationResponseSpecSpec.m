//
//  TMDBConfigurationResponseSpecSpec.m
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright 2015 Chao Ruan. All rights reserved.
//

#import "TMDBKit.h"
#import "TMDBTestHelper.h"


SpecBegin(TMDBConfigurationResponseSpec)

describe(@"TMDBConfigurationResponseSpec", ^{
  NSDictionary *representation = [TMDBTestHelper jsonDictonaryFromClass:TMDBConfigurationResponse.class];
  __block NSError *error;
  
    beforeEach(^{
      error = nil;
    });
    
    it(@"should be from an external representation", ^{
      TMDBConfigurationResponse *response = [MTLJSONAdapter modelOfClass:TMDBConfigurationResponse.class fromJSONDictionary:representation error:&error];
      expect(error).to.beNil();
      expect(response).notTo.beNil();
      expect(response.imageConfiguration).notTo.beNil();
      expect(response.changeKeys.count).equal(53);
    });
    
});

SpecEnd
