//
//  TMDBClient+Season.h
//  TMDBKit
//
//  Created by Chao Ruan on 20/10/2015.
//  Copyright © 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"

@interface TMDBClient (Season)
- (RACSignal*)fecthSeasonForShowID:(NSString*)showID season:(NSInteger)season;
@end
