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
#import "TMDBClient+Account.h"

@implementation TMDBClient (Authentication)

- (RACSignal*)newToken
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"authentication/token/new" parameters:nil];
    return [self enqueueRequest:request resultClass:TMDBTokenResponse.class ];
}

+ (RACSignal*)loginWithUsername:(NSString*)username password:(NSString*)password client:(TMDBClient*)client
{
    __block NSString *request_token;
    return [[[[[client newToken] flattenMap:^RACStream *(TMDBTokenResponse *tokenResponse) {
        request_token = tokenResponse.token;
        NSDictionary *parameters = NSDictionaryOfVariableBindings(username,password,request_token);
        NSURLRequest *request = [client requestWithMethod:@"GET" path:@"authentication/token/validate_with_login" parameters:parameters];
        return [client enqueueRequest:request resultClass:TMDBTokenResponse.class ];
    }] flattenMap:^RACStream *(TMDBTokenResponse *tokenResponse) {
        request_token = tokenResponse.token;
        NSDictionary *parameters = NSDictionaryOfVariableBindings(request_token);
        NSURLRequest *request = [client requestWithMethod:@"GET" path:@"authentication/session/new" parameters:parameters];
        return [client enqueueRequest:request resultClass:TMDBTokenResponse.class ];
    }] flattenMap:^RACStream *(TMDBTokenResponse *tokenResponse) {
        [client updateSessionID:tokenResponse.sessionID];
        return [client userAccount];
    }] flattenMap:^RACStream *(TMDBUser *user) {
        [client updateSessionID:client.sessionID user:user];
        return [RACSignal return:client];
    }];
}

+ (RACSignal*)loginAsGusestWithClient:(TMDBClient*)client
{
    NSURLRequest *request = [client requestWithMethod:@"GET" path:@"authentication/guest_session/new" parameters:nil];
    return [[client enqueueRequest:request resultClass:TMDBGuestSessionResponse.class ]flattenMap:^RACStream *(TMDBGuestSessionResponse *response) {
        [client updateGuestSessionID:response.sessionID];
        return [RACSignal return:RACTuplePack(client, response)];
    }];
}

+ (RACSignal *)authenticatedClientWithSavedCredentials
{
    __block TMDBClient *client = nil;
    return [[[[self restoreCredential] flattenMap:^RACStream *(NSURLCredential *credential) {
        client = [TMDBClient clientWithSessionID:credential.password user:nil];
        return [client userAccount];
    }] flattenMap:^RACStream *(TMDBUser *user) {
        [client updateSessionID:client.sessionID user:user];
        return [RACSignal return:client];
    }]catch:^RACSignal *(NSError *error) {
        return [RACSignal return:[TMDBClient client]];
    }];
}

- (RACSignal*)logout
{
    return [self removeCredential];
}
@end
