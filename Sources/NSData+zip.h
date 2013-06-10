//
//  NSData+zip.h
//
//  Created by Kaz Yoshikawa on 10/11/29.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSData (Zip)

- (NSData *)zlibInflate;
- (NSData *)zlibDeflate;
- (NSData *)gzipInflate;
- (NSData *)gzipDeflate;


@end
