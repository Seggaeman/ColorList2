//
//  NSString+URLEncoding.m
//  SlowWorker
//
//  Created by HDM Ltd on 3/4/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)
-(NSString*)urlEncodeUsingEncoding:(NSStringEncoding)theEncoding
{
    return (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, nil, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(theEncoding));
}
@end
