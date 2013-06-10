//
//  NSScanner+Z.m
//	ZKit
//
//	Copyright: (C) 1997-1998, 2000-2001, 2004-2005 Steve Nygard 
//
//  Created by Kaz Yoshikawa on 10/12/02.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import "NSScanner+Z.h"


@implementation NSScanner (ewoods)

- (unichar)peekChar
{
    return [[self string] characterAtIndex:[self scanLocation]];
}

- (BOOL)scanCharacter:(unichar)aChar
{
	if ([self isAtEnd]) return NO;

	unichar ch = [[self string] characterAtIndex:[self scanLocation]];
	if (aChar == ch) {
		[self setScanLocation:[self scanLocation] + 1];
		return YES;
	}
	
	return NO;
}

- (BOOL)scanCharacterIntoString:(NSString **)value;
{
	if ([self isAtEnd]) return NO;

	NSUInteger location = [self scanLocation];
	unichar ch = [[self string] characterAtIndex:location];
	[self setScanLocation:location + 1];
	*value = [NSString stringWithCharacters:&ch length:1];
	return YES;
}

- (BOOL)scanCharacterFromSet:(NSCharacterSet *)set intoString:(NSString **)value;
{
	if ([self isAtEnd] == YES) return NO;

	unichar ch = [[self string] characterAtIndex:[self scanLocation]];
	if ([set characterIsMember:ch] == YES) {
		if (value != NULL) {
			*value = [NSString stringWithCharacters:&ch length:1];
		}

		[self setScanLocation:[self scanLocation] + 1];
		return YES;
	}

	return NO;
}

- (BOOL)scanWhitespaceCharacters
{
	NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
	NSUInteger location = [self scanLocation];
	NSUInteger length = [[self string] length];
	BOOL result = NO;
	while (location < length) {
		unichar ch = [[self string] characterAtIndex:location];
		if ([charSet characterIsMember:ch]) { 
			location++;
			result = YES;
		}
		else break;
	}
	[self setScanLocation:location];
	return result;
}

- (BOOL)scanWhitespaceAndNewlineCharacters
{
	NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSUInteger location = [self scanLocation];
	NSUInteger length = [[self string] length];
	BOOL result = NO;
	while (location < length) {
		unichar ch = [[self string] characterAtIndex:location];
		if ([charSet characterIsMember:ch]) { 
			location++;
			result = YES;
		}
		else break;
	}
	[self setScanLocation:location];
	return result;
}

- (BOOL)scanHexadecimalCharacter:(NSUInteger *)aValue
{
	if ([self isAtEnd] == YES) return NO;

	unichar ch = [[self string] characterAtIndex:[self scanLocation]];
	BOOL result = NO;
	
	switch (ch) {
	case '0'...'9': *aValue = ch - '0'; result = YES; break;
	case 'a'...'f': *aValue = ch - 'a' + 10; result = YES; break;
	case 'A'...'F': *aValue = ch - 'A' + 10; result = YES; break;
	}
	if (result) [self setScanLocation:[self scanLocation]+1];
	return result;
}

- (BOOL)scanDecimalCharacter:(NSUInteger *)aValue
{
	if ([self isAtEnd] == YES) return NO;

	unichar ch = [[self string] characterAtIndex:[self scanLocation]];
	BOOL result = NO;
	
	switch (ch) {
	case '0'...'9': *aValue = ch - '0'; result = YES; break;
	}
	if (result) [self setScanLocation:[self scanLocation]+1];
	return result;
}

@end
