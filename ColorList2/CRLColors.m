//
//  CRLColors.m
//  ColorList
//
//  Created by HDM Ltd on 3/25/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLColors.h"

@implementation CRLColors

-(id)initWithTitle:(NSString *)theTitle AnduserName:(NSString *)theuserName
{
    if (self= [super init])
    {
        self->_title = theTitle;
        self->_userName = theuserName;
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)ipDictionary
{
    if (self= [super init])
    {
        self->_title = ipDictionary[@"title"];
        self->_userName = ipDictionary[@"userName"];
        self->_colorString = ipDictionary[@"hex"];
    }
    return self;
}
@end
