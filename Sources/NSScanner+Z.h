//
//  NSScanner+Z.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/12/02.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSScanner (Z)

- (unichar)peekChar;
- (BOOL)scanCharacter:(unichar)aChar;
- (BOOL)scanCharacterIntoString:(NSString **)value;
- (BOOL)scanCharacterFromSet:(NSCharacterSet *)set intoString:(NSString **)value;
- (BOOL)scanWhitespaceCharacters;
- (BOOL)scanWhitespaceAndNewlineCharacters;
- (BOOL)scanHexadecimalCharacter:(NSUInteger *)aValue;
- (BOOL)scanDecimalCharacter:(NSUInteger *)aValue;

@end
