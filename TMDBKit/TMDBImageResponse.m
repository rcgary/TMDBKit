//
//  TMDBImageResponse.m
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBImageResponse.h"
#import "TMDBImage.h"

@implementation TMDBImageResponse

+ (NSValueTransformer*)backdropsJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:TMDBImage.class];
}

+ (NSValueTransformer*)postersJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:TMDBImage.class];
}
@end
