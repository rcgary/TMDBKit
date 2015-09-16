//
//  TMDBAccountStatesResponse.h
//  TMDBKit
//
//  Created by Chao Ruan on 16/09/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TMDBAccountStatesResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic, assign, readonly) BOOL favorite;
@property (nonatomic, assign, readonly) BOOL watchlist;
@property (nonatomic, assign, readonly) double rated;
@property (nonatomic, copy, readonly) NSString *mediaID;
@end
