//
//  ZAlertView.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/01/10.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "ZAlertView.h"
#import "ZAction.h"


//
//	ZAlertView
//
@implementation ZAlertView

- (id)initWithTitle:(NSString *)aTitle message:(NSString *)aMessage cancelAction:(ZAction *)aCancelAction otherActions:(NSArray *)aOtherActions
{
	if ((self = [super initWithTitle:aTitle message:aMessage delegate:self cancelButtonTitle:aCancelAction.title
				otherButtonTitles:nil])) {
		for (ZAction *action in aOtherActions) {
			NSParameterAssert([action isKindOfClass:[ZAction class]]);
			NSParameterAssert(action.title);
			[self addButtonWithTitle:action.title];
		}
		self.cancelAction = aCancelAction;
		self.otherActions = aOtherActions;
	}
	return self;
}

#pragma mark -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	ZAction *action = nil;
	if (self.cancelAction && self.cancelAction.title) {
		action = (buttonIndex == 0) ? self.cancelAction : [self.otherActions objectAtIndex:buttonIndex - 1];
	}
	else {
		action = [self.otherActions objectAtIndex:buttonIndex];
	}
	[action performAction];
}

- (id)delegate
{
	return self;
}

@end
