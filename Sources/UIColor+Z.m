//
//  UIColor+Z.m
//	ZKit
//
//  Created by Kaz Yohsikawa on 1/21/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import "UIColor+Z.h"
#import "ZColorUtils.h"

//
//	UIColor (Z)
//

@implementation UIColor (Z)

+ (UIColor *)UIColorFromString:(NSString *)string
{
	ZRGBA rgba = ZRGBAFromString(string);
	return [UIColor colorWithRed:rgba.r green:rgba.g blue:rgba.b alpha:rgba.a];
}

@end
