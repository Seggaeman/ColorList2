//
//  CRLPalettes.h
//  ColorList2
//
//  Created by HDM Ltd on 3/28/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iActiveRecord/ActiveRecord.h>

@interface CRLPalettes: ActiveRecord

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* userName;
@property (strong,nonatomic) NSString* imageUrl;

-(id)initWithDictionary:(NSDictionary*)pDictionary;
@end
