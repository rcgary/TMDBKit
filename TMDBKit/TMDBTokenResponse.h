//
//  TMDBTokenResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 29/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TMDBTokenResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSString *token;
@property (nonatomic, copy, readonly) NSString *sessionID;
@end
