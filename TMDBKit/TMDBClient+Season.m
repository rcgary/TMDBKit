//
//  TMDBClient+Season.m
//  TMDBKit
//
//  Created by Chao Ruan on 20/10/2015.
//  Copyright © 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient+Season.h"
#import "TMDBSeason.h"

@implementation TMDBClient (Season)
- (RACSignal*)fecthSeasonForShowID:(NSString*)showID season:(NSInteger)season
{
    NSString *path = [NSString stringWithFormat:@"tv/%@/season/%ld",showID,(long)season];
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil ];
    return [self enqueueRequest:request resultClass:TMDBSeason.class ];
}
@end
