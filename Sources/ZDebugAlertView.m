//
//  ZDebugAlertView.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/2/12.
//  Copyright (c) 2012 Electricwoods LLC. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "ZDebugAlertView.h"
#import "NSDate+Z.h"



#if DEBUG
void ZDebugAlert(NSString *title, NSString *message)
{
	[[[ZDebugAlertView alloc] initWithTitle:title message:message] show];
}
#endif


//
//	 ZDebugAlertView ()
//

@interface ZDebugAlertView ()

@end


//
//	ZDebugAlertView
//

@implementation ZDebugAlertView

- (id)initWithTitle:(NSString *)title message:message
{
	if (self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]) {
	}
	return self;
}

- (void)show
{
	[super show];
}

@end
