//
//  UIImage+Z.h
//
//  Created by Kaz Yoshikawa on 10/10/25.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//
//	UIImage (Z)
//
@interface UIImage (Z)

+ (NSData *)imageDataWithContentsOfFile_:(NSString *)file;
+ (UIImage *)imageWithContentsOfFile_:(NSString *)file;
+ (NSData *)imageDataWithContentsOfURL_:(NSURL *)imageURL;
+ (UIImage *)imageWithContentsOfURL_:(NSURL *)imageURL;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

@end
