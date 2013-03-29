//
//  CRLPalettes.m
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLPalettes.h"

@implementation CRLPalettes

-(id)initWithDictionary:(NSDictionary *)pDictionary
{
    if (self = [super init])
    {
        self.userName = pDictionary[@"userName"];
        self.title= pDictionary[@"title"];
        self.imageUrl = pDictionary[@"imageUrl"];
        self.isSelected = [NSNumber numberWithInt:NO];
    }
    return self;
}
@end
