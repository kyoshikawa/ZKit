//
//  NSUserDefaults+Z.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/01/04.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


//
//	NSUserDefaults (Z)
//
@interface NSUserDefaults (ewoods)

- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;

@end
