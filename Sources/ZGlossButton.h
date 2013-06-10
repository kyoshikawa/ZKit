//
//  ZGlossButton.h
//	ZKit
//
//  Created by kyoshikawa on 1/8/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZGlossButton : UIButton

@property (strong) id context;
@property (strong) UIColor *buttonColor;
@property (assign) CGFloat gloss;				// 0.0f ~ 1.0f

@end
