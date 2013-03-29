//
//  NSString+URLEncoding.h
//  SlowWorker
//
//  Created by HDM Ltd on 3/4/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
-(NSString*)urlEncodeUsingEncoding: (NSStringEncoding)theEncoding;
@end
