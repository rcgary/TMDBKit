//
//  TMDBGuestSessionResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 29/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TMDBGuestSessionResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSString *sessionID;
@property (nonatomic, copy, readonly) NSDate *expiresAt;
@end
