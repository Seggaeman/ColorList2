//
//  CRLPattern.m
//  ColorList2
//
//  Created by HDM Ltd on 3/29/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLPattern.h"


@implementation CRLPattern

-(id)initWithDictionary:(NSDictionary *)jsonDictionary
{
    if (self = [super init])
    {
        self->_userName = jsonDictionary[@"userName"];
        self->_title = jsonDictionary[@"title"];
        self->_imageUrl = jsonDictionary[@"imageUrl"];
    }
    return self;
}
@end
