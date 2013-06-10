//
//  NSString+Z.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/12/07.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import "NSString+Z.h"


@implementation NSString (Z)

+ (NSString *)UUID
{
	CFUUIDRef uuidRef = CFUUIDCreate(NULL);
	CFStringRef stringRef = CFUUIDCreateString(NULL, uuidRef);
	CFRelease(uuidRef);
	return (NSString *)CFBridgingRelease(stringRef);
}

+ (NSString *)stringWithDataSize:(uint64_t)aDataSize
{
	const double kKiro = 1000.0;
	const double kMega = kKiro * 1000.0;
	const double kGiga = kMega * 1000.0;
	const double kTera = kGiga * 1000.0;

	double kiro = aDataSize / kKiro;
	double mega = aDataSize / kMega;
	double giga = aDataSize / kGiga;
	double tera = aDataSize / kTera;

	NSString *dataSizeString = nil;
	if (tera > 1.0) dataSizeString = [NSString stringWithFormat:@"%.1fT", tera];
	else if (giga > 1.0) dataSizeString = [NSString stringWithFormat:@"%.1fG", giga];
	else if (mega > 1.0) dataSizeString = [NSString stringWithFormat:@"%.1fM", mega];
	else if (kiro > 1.0) dataSizeString = [NSString stringWithFormat:@"%.1fK", kiro];
	else dataSizeString = [NSString stringWithFormat:@"%lldB", aDataSize];
	
	return dataSizeString;
}

+ (NSString *)stringWithInteger:(NSInteger)aInteger
{
	NSNumber *number = [[NSNumber alloc] initWithInteger:aInteger];
	NSString *string = [number stringValue];
	return string;
}

+ (NSString *)romanNumeralWithInteger:(NSInteger)aInteger
{
    NSInteger n = aInteger;
    NSUInteger valueCount = 13;
    NSArray *numerals = [NSArray arrayWithObjects:@"m", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I", nil];
    NSUInteger values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    
    NSMutableString *numeralString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < valueCount; i++) {
        while (n >= values[i]) {
            n -= values[i];
            [numeralString appendString:[numerals objectAtIndex:i]];
        }
    }
    
    return [numeralString lowercaseString];
}


#pragma mark -

- (NSString *)hexadecimalString
{
	static char hexchars[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
	NSMutableString *string = [NSMutableString string];
	NSUInteger length = self.length;
	unichar ch;
	for (NSUInteger index = 0 ; index < length ; index++) {
		ch = [self characterAtIndex:index];
		NSUInteger ch4 = (ch & 0x000f) >> 0;
		NSUInteger ch3 = (ch & 0x00f0) >> 4;
		NSUInteger ch2 = (ch & 0x0f00) >> 8;
		NSUInteger ch1 = (ch & 0xf000) >> 12;
		[string appendFormat:@"%c%c%c%c", hexchars[ch1], hexchars[ch2], hexchars[ch3], hexchars[ch4]];
	}
	return string;
}

- (NSComparisonResult)likeFinderCompare:(NSString*)string
{
    static CFOptionFlags compareOptions = kCFCompareCaseInsensitive |
				kCFCompareNonliteral |
				kCFCompareLocalized |
				kCFCompareNumerically |
				kCFCompareWidthInsensitive |
				kCFCompareForcedOrdering;
	NSString* selfString = [[self lastPathComponent] stringByDeletingPathExtension];
    CFRange string1Range = CFRangeMake(0, CFStringGetLength( (CFStringRef)(selfString) ));
	
    return (NSComparisonResult)CFStringCompareWithOptionsAndLocale((CFStringRef)(selfString), (CFStringRef)[[string lastPathComponent] stringByDeletingPathExtension], string1Range, compareOptions, NULL);
}

- (BOOL)beginsWithString:(NSString *)aString
{
	NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
	if (range.location == 0 && range.length == [aString length]) return YES;
	return NO;
}

- (BOOL)endsWithString:(NSString *)aString
{
	NSRange range = [self rangeOfString:aString options:NSBackwardsSearch|NSCaseInsensitiveSearch];
	if (range.location + [aString length] == [self length]) return YES;
	return NO;
}

- (BOOL)containsString:(NSString *)aString
{
	NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch];
	if (range.location != NSNotFound && range.length > 0) return YES;
	return NO;
}

- (NSString *)stringByDeletingPrefix:(NSString *)aPrefix
{
	NSRange range = [self rangeOfString:aPrefix];
	if (range.location == 0 && range.length == [aPrefix length]) {
		return [self substringFromIndex:[aPrefix length]];
	}
	return self;
}

- (NSString *)stringByDeletingSuffix:(NSString *)aSuffix
{
	NSRange range = [self rangeOfString:aSuffix options:NSBackwardsSearch];
	if (range.location != NSNotFound && range.length == [aSuffix length]) {
		return [self substringToIndex:range.location];
	}
	return self;
}

- (NSString *)stringByTrimmingWhiteCharacters
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
