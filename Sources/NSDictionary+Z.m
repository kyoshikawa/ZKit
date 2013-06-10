//
//  NSDictionary+Z.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/03/09.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "NSDictionary+Z.h"


//
//	NSDictionary
//
@implementation NSDictionary (Z)

- (NSString *)localizedString
{
	NSString *string = nil;
	for (NSString *language in [NSLocale preferredLanguages]) {
		string = [self valueForKey:language];
		if (string) return string;
	}
	return [[self allValues] lastObject];
}

- (BOOL)writeToURLBinaryPropertyList:(NSURL*)URL atomically:(BOOL)flag error:(NSError **)errorPtr
{
	NSString* errorString = nil;
	BOOL isSuccess = NO;
	NSData* data = [NSPropertyListSerialization dataFromPropertyList:self format:kCFPropertyListBinaryFormat_v1_0 errorDescription:&errorString];
	if(errorString){
		NSLog(@"Failed NSDictionary+Z writeToURLBinaryPropertyList:atomically:error: create data %@", URL);
		isSuccess = NO;
		goto end;
	}
	
	NSDataWritingOptions options = 0;
	if(flag){
		options = NSDataWritingAtomic;
	}
	
	isSuccess = [data writeToURL:URL options:options error:errorPtr];
	if(NO == isSuccess){
		NSLog(@"Failed NSDictionary+Z writeToURLBinaryPropertyList:atomically:error: save data %@", URL);
		goto end;
	}
end:
	return isSuccess;
}

@end
