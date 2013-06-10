//
//  ZAction.h
//
//  Created by Kaz Yoshikawa on 11/01/10.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//	ZKit
//

#import <Foundation/Foundation.h>

//	ZAction
//
//	ZAction is utility class to do equivalent to when necessary.
//
//		[target performSelector:@selector(action) withObject:object];
//



//
//	ZAction
//

@interface ZAction : NSObject

@property (retain) NSString *title;
@property (assign) id <NSObject> target;
@property (assign) SEL action;
@property (retain) id <NSObject> object;

+ (ZAction *)actionWithTitle:(NSString *)aTitle target:(id)aTarget action:(SEL)aAction object:(id)aObject;
- (void)performAction;

@end

