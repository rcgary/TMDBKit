//
//  TMDBSpecSpec.m
//  TMDBKit
//
//  Created by Chao Ruan on 24/07/2015.
//  Copyright 2015 Chao Ruan. All rights reserved.
//

#import "TMDBTestHelper.h"

SpecBegin(TMDBSpec)

describe(@"TMDBSpec", ^{
    NSString *apikey = @"2449630792c1f2e7c806b4ab2ee826b5";
    TMDBClient *client = [TMDBClient clientWithAPIKey:apikey];
    __block NSError*error;
    
    beforeAll(^{
        error = nil;
        
    });
    
    beforeEach(^{
        
    });
    
    it(@"just a test", ^{
        RACSignal *signal = [TMDBClient loginAsGusestWithClient:client];
        BOOL result = [signal asynchronouslyWaitUntilCompleted:&error];
        expect(result).to.beTruthy();
        expect(error).to.beNil();
    });
    
    afterEach(^{
        
    });
    
    afterAll(^{
        
    });
});

SpecEnd
