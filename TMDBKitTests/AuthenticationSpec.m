//
//  AuthenticationSpecSpec.m
//  TMDBKit
//
//  Created by Chao Ruan on 30/07/2015.
//  Copyright 2015 Chao Ruan. All rights reserved.
//

#import "TMDBTestHelper.h"


SpecBegin(Authentication)

describe(@"Authentication", ^{
    __block BOOL success;
    __block NSError *error;
    __block TMDBClient *client;
    beforeAll(^{
    });
    
    beforeEach(^{
        client = [TMDBClient client];
        success = NO;
        error = nil;
    });
    
    it(@"should login with username and password", ^{
        NSDictionary *newTokenResponse = @{
                                           @"success": @YES,
                                           @"expires_at": @"2015-07-29 11:02:08 UTC",
                                           @"request_token": @"be734eb62caf217c9185b34e878b17f28537b8e8"
                                           };
        
        NSDictionary *tokenResponse = @{
                                        @"success": @YES,
                                        @"request_token": @"d5668f34e0643f312da021848891d17e89febed8"
                                        };
        
        NSDictionary *sessionResponse = @{
                                          @"success": @YES,
                                          @"session_id": @"0dcf0e46bf1ab29cbd9718babac91d6fe39da337"
                                          };
        
        [TMDBStubber stubResponseWithPath:@"authentication/token/new" responseObject:newTokenResponse];
        [TMDBStubber stubResponseWithPath:@"authentication/token/validate_with_login" responseObject:tokenResponse];
        [TMDBStubber stubResponseWithPath:@"authentication/session/new" responseObject:sessionResponse];
        
        RACSignal *signal = [TMDBClient loginWithUsername:@"username" password:@"password" client:client];
        TMDBClient *authenticatedClient = [signal asynchronousFirstOrDefault:nil success:&success error:&error];
        expect(success).to.beTruthy();
        expect(error).to.beNil();
        expect(authenticatedClient).notTo.beNil();
        expect(authenticatedClient.isAuthenticated).to.beTruthy();
    });
    
    it(@"should login as guest", ^{
        NSDictionary *guestSessionResponse = @{
                                               @"success": @YES,
                                               @"guest_session_id": @"ab964753ebe95ee53f19999138cea63e",
                                               @"expires_at": @"2015-07-30 10:39:15 UTC"
                                               };
        [TMDBStubber stubResponseWithPath:@"authentication/guest_session/new" responseObject:guestSessionResponse];
        RACSignal *signal = [TMDBClient loginAsGusestWithClient:client];
        RACTuple *tuple = [signal asynchronousFirstOrDefault:nil success:&success error:&error];
        TMDBClient *guestClient = tuple.first;
        TMDBGuestSessionResponse *sessionResponse = tuple.second;
        
        expect(success).to.beTruthy();
        expect(error).to.beNil();
        expect(guestClient).notTo.beNil();
        expect(guestClient.isAuthenticated).to.beTruthy();
        expect(sessionResponse.sessionID).equal(@"ab964753ebe95ee53f19999138cea63e");
        expect(sessionResponse.expiresAt).beKindOf(NSDate.class);
        
    });
    
    afterEach(^{
        [OHHTTPStubs removeAllStubs];
    });
    
});

SpecEnd
