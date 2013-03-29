//
//  URLBuilder.m
//  ColorList2
//
//  Created by HDM Ltd on 3/27/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "URLBuilder.h"
#import "NSString+URLEncoding.h"
@implementation URLBuilder
+(NSString*)serializeURLString:(NSString*)baseURLString withArguments:(NSDictionary*)arguments
{
    //serialize input data
    NSMutableString* serializedString = [baseURLString mutableCopy];
    
    __block NSUInteger idx = 0;
    [arguments enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (idx > 0)
        {
            [serializedString appendString:@"&"];
        }
        [serializedString appendString:[(NSString*)key urlEncodeUsingEncoding:NSUTF8StringEncoding]];
        [serializedString appendString:@"="];
        [serializedString appendString:[(NSString*)obj urlEncodeUsingEncoding:NSUTF8StringEncoding]];
        ++idx;
    }];
    return serializedString;
}
/*
+(void)HTTPRequest:(NSURL *)theURL requestMethod:(NSString *)theMethod requestData:(NSMutableDictionary *)inputData URLConnectionDelegate:(id<NSURLConnectionDelegate>)theDelegate
{
    //serialize input data.
    NSMutableString* serializedString = [[NSMutableString alloc] init];;
    NSArray* inputKeys= [inputData allKeys];
    
    for (int idx =0; idx < [inputKeys count]; ++idx)
    {
        if (idx > 0)
        {
            [serializedString appendString:@"&"];
        }
        NSString* laClef= [inputKeys objectAtIndex:idx];
        [serializedString appendString:[laClef urlEncodeUsingEncoding:NSUTF8StringEncoding]];
        [serializedString appendString:@"="];
        [serializedString appendString:[[inputData objectForKey:laClef] urlEncodeUsingEncoding:NSUTF8StringEncoding]];
    }
    //NSLog(@"%@", serializedString);
    NSMutableURLRequest* laRequete= [[NSMutableURLRequest alloc] init];
    [laRequete setHTTPMethod:theMethod];
    [laRequete setURL:theURL];
    [laRequete setHTTPBody:[serializedString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection* laConnexion= [[NSURLConnection alloc] initWithRequest:laRequete delegate:theDelegate startImmediately:YES];
}
*/
@end
