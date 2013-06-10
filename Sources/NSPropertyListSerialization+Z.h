//
//  NSPropertyListSerialization+Z.h
//  ZKit
//
//  Created by Kaz Yoshikawa on 6/10/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//	NSPropertyListSerialization
//

@interface NSPropertyListSerialization (Z)

+ (NSData *)dataWithPropertyList:(id)plist error:(NSError **)error;
+ (id)propertyListWithData:(NSData *)data error:(NSError **)error;


@end
