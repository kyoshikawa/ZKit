//
//  UIDevice+Z.h
//	ZKit
//
//  Created by Kaz Yoshikawa  on 10/7/11.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


//
//	UIDevice (Z)
//
@interface UIDevice (Z)

+ (BOOL)iPad;
+ (BOOL)iPhone;
+ (NSData *)macaddress;
- (NSString *)modelIdentifier;

@end
