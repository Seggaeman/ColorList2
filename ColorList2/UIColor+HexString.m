//
//  UIColor+HexString.m
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)

+(UIColor*)colorWithHexString:(NSString *)hexString inverted:(BOOL)status
{
    //parse the hex string.
    CGFloat (^getColorComp)(int, int) = ^CGFloat(int origin, int length) {
        NSString* compSubstr= [hexString substringWithRange:NSMakeRange(origin, length)];
        CGFloat colorComp = (double)strtol([compSubstr UTF8String], NULL, 16) / 255.0;
        return colorComp;
    };
    if (status == YES)
        return [UIColor colorWithRed:(1.0-getColorComp(0,2)) green:(1.0-getColorComp(2,2)) blue:(1.0-getColorComp(4,2)) alpha:1.0];
    else
        return [UIColor colorWithRed:getColorComp(0,2) green:getColorComp(2,2) blue:getColorComp(4,2) alpha:1.0];
}
@end
