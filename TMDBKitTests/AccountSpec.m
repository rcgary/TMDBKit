//
//  AccountSpec.m
//  TMDBKit
//
//  Created by Chao Ruan on 1/08/2015.
//  Copyright 2015 Chao Ruan. All rights reserved.
//

#import "TMDBTestHelper.h"


SpecBegin(Account)

describe(@"Account", ^{
    __block BOOL success;
    __block NSError *error;
    TMDBClient *client = [TMDBTestHelper testClient];
    
    beforeAll(^{

    });
    
    beforeEach(^{
        success = NO;
        error = nil;
    });
    
    
    it(@"should get user lists", ^{
        NSDictionary *pageResponse = @{
            @"page": @1,
            @"results": @[],
            @"total_pages": @0,
            @"total_results": @0
            };
        NSString *path = [NSString stringWithFormat:@"account/%@/lists",client.user.objectID];
        [TMDBStubber stubResponseWithPath:path responseObject:pageResponse];
        RACSignal *signal = [client getUserLists];
        NSArray *response = [signal asynchronousFirstOrDefault:nil success:&success error:&error];
        
        expect(error).to.beNil();
        expect(success).to.beTruthy();
        expect(response).notTo.beNil();
    });
    
    afterEach(^{

    });
    
    afterAll(^{

    });
});

SpecEnd
