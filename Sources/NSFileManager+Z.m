//
//  NSFileManager+Z.m
//  Electricbooks
//
//  Created by Kaz Yoshikawa on 1/6/12.
//  Copyright (c) 2012 Electricwoods LLC. All rights reserved.
//

#import "NSFileManager+Z.h"
#include <sys/xattr.h>

//
//	NSFileManager (Z)
//

@implementation NSFileManager (Z)

- (void)applyDoNotBackupAttributeAtPath:(NSString *)aPath
{
	BOOL isDir;
	BOOL exists = [self fileExistsAtPath:aPath isDirectory:&isDir];
	if (exists) {
		const char* filePath = [aPath fileSystemRepresentation];
		const char* attrName = "com.apple.MobileBackup";
		u_int8_t attrValue = 1;

		int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
		if (result != 0) NSLog(@"failed to set 'do-not-backup' attribute: %@", [aPath stringByAbbreviatingWithTildeInPath]);
	}
}

@end
