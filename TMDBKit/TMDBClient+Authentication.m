//
//  TMDBClient+Authentication.m
//  TMDBKit
//
//  Created by Chao Ruan on 29/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+Authentication.h"
#import "TMDBTokenResponse.h"
#import "TMDBGuestSessionResponse.h"

@implementation TMDBClient (Authentication)

- (RACSignal*)newToken
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"authentication/token/new" parameters:nil pageing:NO];
    return [self enqueueRequest:request resultClass:TMDBTokenResponse.class fetchAllPages:NO];
}

+ (RACSignal*)loginWithUsername:(NSString*)username password:(NSString*)password client:(TMDBClient*)client
{
    __block NSString *request_token;
    return [[[[client newToken] flattenMap:^RACStream *(TMDBTokenResponse *tokenResponse) {
        request_token = tokenResponse.token;
        NSDictionary *parameters = NSDictionaryOfVariableBindings(username,password,request_token);
        NSURLRequest *request = [client requestWithMethod:@"GET" path:@"authentication/token/validate_with_login" parameters:parameters pageing:NO];
        return [client enqueueRequest:request resultClass:TMDBTokenResponse.class fetchAllPages:NO];
    }] flattenMap:^RACStream *(TMDBTokenResponse *tokenResponse) {
        request_token = tokenResponse.token;
        NSDictionary *parameters = NSDictionaryOfVariableBindings(request_token);
        NSURLRequest *request = [client requestWithMethod:@"GET" path:@"authentication/session/new" parameters:parameters pageing:NO];
        return [client enqueueRequest:request resultClass:TMDBTokenResponse.class fetchAllPages:NO];
    }] flattenMap:^RACStream *(TMDBTokenResponse *tokenResponse) {
        return [[client updateSessionID:tokenResponse.sessionID username:username]
                concat:[RACSignal return:client]];
    }];
}

+ (RACSignal*)loginAsGusestWithClient:(TMDBClient*)client
{
    NSURLRequest *request = [client requestWithMethod:@"GET" path:@"authentication/guest_session/new" parameters:nil pageing:NO];
    return [[client enqueueRequest:request resultClass:TMDBGuestSessionResponse.class fetchAllPages:NO]flattenMap:^RACStream *(TMDBGuestSessionResponse *response) {
        return [[client updateGuestSessionID:response.sessionID]
                concat:[RACSignal return:RACTuplePack(client, response)]];
    }];
}

+ (RACSignal *)authenticatedClientWithSavedCredentials
{
    return [[self restoreCredential] flattenMap:^RACStream *(NSURLCredential *credential) {
        TMDBClient *client = [TMDBClient clientWithSessionID:credential.password username:credential.user];
        return [RACSignal return:client];
    }];
}

- (RACSignal*)logout
{
    return [self removeCredential];
}
@end
