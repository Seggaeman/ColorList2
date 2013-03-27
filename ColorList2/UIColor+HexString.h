//
//  UIColor+HexString.h
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
+ (UIColor*)colorWithHexString:(NSString*)hexString inverted:(BOOL)status;
@end
