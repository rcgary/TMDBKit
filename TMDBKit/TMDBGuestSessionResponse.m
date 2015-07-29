//
//  TMDBGuestSessionResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 29/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBGuestSessionResponse.h"

@implementation TMDBGuestSessionResponse 
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"expiresAt" : @"expires_at",
             @"sessionID" : @"guest_session_id"
             };
}

+ (NSDateFormatter*)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale = [NSLocale currentLocale];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss z";
    });
    return dateFormatter;
}

+ (NSValueTransformer*)expiresAtJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string, BOOL *success, NSError **error) {
        return [self.dateFormatter dateFromString:string];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError **error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}
@end
