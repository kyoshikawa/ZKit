//
//  NSDictionary+Z.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/03/09.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


//
//	NSDictionary
//
@interface NSDictionary (Z)

- (NSString *)localizedString;
- (BOOL)writeToURLBinaryPropertyList:(NSURL*)URL atomically:(BOOL)flag error:(NSError **)errorPtr;

@end
