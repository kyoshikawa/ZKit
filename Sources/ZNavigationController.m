//
//  ZNavigationController.m
//  ZKit
//
//  Created by kyoshikawa on 3/12/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import "ZNavigationController.h"

//
//	ZNavigationController ()
//

@interface ZNavigationController ()

@end


//
//	ZNavigationController
//

@implementation ZNavigationController

- (NSUInteger)supportedInterfaceOrientations
{
	return [self.topViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
	return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return [self.topViewController preferredInterfaceOrientationForPresentation];
}


@end
