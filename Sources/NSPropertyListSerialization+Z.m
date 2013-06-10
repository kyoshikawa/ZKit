//
//  NSPropertyListSerialization+Z.m
//  ZKit
//
//  Created by kyoshikawa on 6/10/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import "NSPropertyListSerialization+Z.h"


//
//	NSPropertyListSerialization
//

@implementation NSPropertyListSerialization (Z)

+ (NSData *)dataWithPropertyList:(id)plist error:(NSError **)error
{
	NSData *data = nil;
	if (plist) {
		data = [NSPropertyListSerialization dataWithPropertyList:plist format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
	}
	return data;
}

+ (id)propertyListWithData:(NSData *)data error:(NSError **)error
{
	id plist = nil;
	if (data) {
		plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
	}
	return plist;
}

@end
