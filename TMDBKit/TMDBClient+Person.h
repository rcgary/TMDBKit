//
//  TMDBClient+Person.h
//  TMDBKit
//
//  Created by Chao Ruan on 2/08/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBClient.h"

@interface TMDBClient (Person)
- (RACSignal*)personFromID:(NSString*)personID;
- (RACSignal*)popularPerson;
- (RACSignal*)latestPerson;
@end
