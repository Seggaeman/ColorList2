//
//  URLBuilder.h
//  ColorList2
//
//  Created by HDM Ltd on 3/27/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLBuilder : NSObject

+(NSString*)serializeURLString:(NSString*)baseURLString withArguments:(NSDictionary*)arguments;
@end
