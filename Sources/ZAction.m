//
//  ZAction.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/01/10.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "ZAction.h"


//
//	ZAction
//

@implementation ZAction

@synthesize title;
@synthesize target;
@synthesize action;
@synthesize object;

+ (ZAction *)actionWithTitle:(NSString *)title target:(id)target action:(SEL)action object:(id)object
{
	ZAction *actionObject = [[ZAction alloc] init];
	actionObject.title = title;
	actionObject.target = target;
	actionObject.action = action;
	actionObject.object = object;
	return actionObject;
}

- (void)performAction
{
	if (target && action) {

		#pragma clang diagnostic push
		#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		[self.target performSelector:action withObject:object];
		#pragma clang diagnostic pop
	}
}

@end
