//
//  NSString+Z.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/12/07.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Z)

+ (NSString *)UUID;
+ (NSString *)stringWithDataSize:(uint64_t)aDataSize;
+ (NSString *)stringWithInteger:(NSInteger)aInteger;
+ (NSString *)romanNumeralWithInteger:(NSInteger)aInetegr;

- (NSString *)hexadecimalString;
- (NSComparisonResult)likeFinderCompare:(NSString*)string;
- (BOOL)beginsWithString:(NSString *)aString;
- (BOOL)endsWithString:(NSString *)aString;
- (BOOL)containsString:(NSString *)aString;
- (NSString *)stringByDeletingPrefix:(NSString *)aPrefix;
- (NSString *)stringByDeletingSuffix:(NSString *)aSuffix;
- (NSString *)stringByTrimmingWhiteCharacters;

@end
