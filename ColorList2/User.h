//
//  user.h
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iActiveRecord/ActiveRecord.h>

@interface User : ActiveRecord

@property (strong,nonatomic) NSString* userName;
@property (strong, nonatomic) NSNumber* rating;
@property (strong,nonatomic) NSString* location;
@property (strong,nonatomic) NSNumber* numColors;

-(id)initWithDictionary:(NSDictionary*)infoDictionary;
@end
