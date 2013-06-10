//
//  NSData+AES256.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/06/26.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (AES256)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end