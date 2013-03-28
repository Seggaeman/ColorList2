//
//  user.m
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithDictionary:(NSDictionary *)infoDictionary
{
    if (self = [super init])
    {
        self.userName = infoDictionary[@"userName"];
        self.rating = infoDictionary[@"rating"];
        self.location = infoDictionary[@"location"];
        self.numColors = infoDictionary[@"numColors"];
    }
    return self;
}
@end
