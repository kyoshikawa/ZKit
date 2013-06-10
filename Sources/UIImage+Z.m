//
//  UIImage+Z.m
//
//  Created by Kaz Yoshikawa on 10/10/25.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import "UIImage+Z.h"
#import "ZGeometricUtils.h"


//
//	UIImage (Z)
//
@implementation UIImage (Z)

static NSArray *image_modifiers()
{
	//	EXAMPLES:
	//
	//	iPad3:		"foo@2x~ipad.png", "foo@2x.png", "foo~ipad.png", "foo.png"
	//	iPad2:		"foo~ipad.png", "foo.png"
	//	iPhone4:	"foo@2x~iphone.png","foo@2x.png", "foo~iphone.png" "foo.png"
	//	iPhone3GS:	"foo~iphone.png", "foo.png"

	NSString *idiom = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? @"~ipad" : @"~iphone";

	NSMutableArray *modifiers = [NSMutableArray array];
	if ([UIScreen mainScreen].scale == 2.0) {
		[modifiers addObject:[NSString stringWithFormat:@"@2x%@", idiom]];
		[modifiers addObject:@"@2x"];
	}
	[modifiers addObject:[NSString stringWithFormat:@"%@", idiom]];
	[modifiers addObject:@""];
	return modifiers;
}

+ (UIImage *)imageWithContentsOfFile_:(NSString *)file imageData:(NSData **)imageData
{
	//	try loading the best possible image for the device
	//
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *extension = [file pathExtension];
	NSString *basename = [file stringByDeletingPathExtension];
	
	for (NSString *modifier in image_modifiers()) {
		CGFloat scale = [modifier hasPrefix:@"@2x"] ? 2.0f : 1.0f;
		NSString *path = [[basename stringByAppendingString:modifier] stringByAppendingPathExtension:extension];
		if ([fileManager fileExistsAtPath:path]) {
			NSData *data = [NSData dataWithContentsOfFile:path];
			if (data) {
				UIImage *image = [UIImage imageWithData:data scale:scale];
				if (image) {
					if (imageData) *imageData = data;
					return image;
				}
			}
		}
	}
	return nil;
}

+ (UIImage *)imageWithContentsOfURL_:(NSURL *)URL imageData:(NSData **)imageData
{
	NSURL *baseURL = [URL URLByDeletingLastPathComponent];
	NSString *lastPathComponent = [URL lastPathComponent];
	NSString *baseFileName = [lastPathComponent stringByDeletingPathExtension];
	NSString *extension = [lastPathComponent pathExtension];
	
	for (NSString *modifier in image_modifiers()) {
		CGFloat scale = [modifier hasPrefix:@"@2x"] ? 2.0f : 1.0f;
		NSString *filename = [[baseFileName stringByAppendingString:modifier] stringByAppendingPathExtension:extension];
		NSURL *theURL = [baseURL URLByAppendingPathComponent:filename];
		NSData *data = [NSData dataWithContentsOfURL:theURL];
		if (data) {
			UIImage *image = [UIImage imageWithData:data scale:scale];
			if (image) {
				if (imageData) *imageData = data;
				return image;
			}
		}
	}
	return nil;
}

+ (NSData *)imageDataWithContentsOfFile_:(NSString *)file
{
	NSData *imageData = nil;
	__unused UIImage *image = [self imageWithContentsOfFile_:file imageData:&imageData];
	return imageData;
}

+ (UIImage *)imageWithContentsOfFile_:(NSString *)file
{
	NSData *imageData = nil;
	UIImage *image = [self imageWithContentsOfFile_:file imageData:&imageData];
	return image;
}

+ (NSData *)imageDataWithContentsOfURL_:(NSURL *)imageURL
{
	NSData *imageData = nil;
	__unused UIImage *image = [self imageWithContentsOfURL_:imageURL imageData:&imageData];
	return imageData;
}

+ (UIImage *)imageWithContentsOfURL_:(NSURL *)imageURL
{
	NSData *imageData = nil;
	UIImage *image = [self imageWithContentsOfURL_:imageURL imageData:&imageData];
	return image;
}

#pragma mark -

- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
	UIGraphicsBeginImageContext(self.size);
	CGRect drawRect = CGRectMake(0, 0, self.size.width, self.size.height);
	[self drawInRect:drawRect];
	[tintColor set];
	UIRectFillUsingBlendMode(drawRect, kCGBlendModeSourceAtop);
	UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return tintedImage;
}


@end
