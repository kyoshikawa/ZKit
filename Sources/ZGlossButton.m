//
//  ZGlossButton.m
//	ZKit
//
//  Created by kyoshikawa on 1/8/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import "ZGlossButton.h"
#import "ZGeometricUtils.h"


//
//	ZGlossButton ()
//

@interface ZGlossButton ()

@end


//
//	ZGlossButton
//

@implementation ZGlossButton

- (id)initWithCoder:(NSCoder *)decoder
{
	if (self = [super initWithCoder:decoder]) {
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
	}
	return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
	if (self.highlighted != highlighted) {
		[super setHighlighted:highlighted];
		[self setNeedsDisplay];
	}
	

//    BOOL old = self.highlighted;
//    [super setHighlighted: highlighted];
//    
//    if ( old != highlighted ) {
//        [self setNeedsDisplay];
//	}
}

- (UIBezierPath *)roundRectBezierPath:(CGRect)rect radius:(CGFloat)radius
{
	CGFloat minY = CGRectGetMinY(rect);
	CGFloat maxY = CGRectGetMaxY(rect);
	CGFloat minX = CGRectGetMinX(rect);
	CGFloat maxX = CGRectGetMaxX(rect);

	UIBezierPath *buttonPath = [UIBezierPath bezierPath];
	[buttonPath moveToPoint:CGPointMake(minX+radius, minY)];
	[buttonPath addQuadCurveToPoint:CGPointMake(minX, minY+radius) controlPoint:CGPointMake(minX, minY)];
	[buttonPath addLineToPoint:CGPointMake(minX, maxY-radius)];
	[buttonPath addQuadCurveToPoint:CGPointMake(minX+radius, maxY) controlPoint:CGPointMake(minX, maxY)];
	[buttonPath addLineToPoint:CGPointMake(maxX-radius, maxY)];
	[buttonPath addQuadCurveToPoint:CGPointMake(maxX, maxY-radius) controlPoint:CGPointMake(maxX, maxY)];
	[buttonPath addLineToPoint:CGPointMake(maxX, minY+radius)];
	[buttonPath addQuadCurveToPoint:CGPointMake(maxX-radius, minY) controlPoint:CGPointMake(maxX, minY)];
	[buttonPath closePath];
	return buttonPath;
}

static void HSVtoRGB_(CGFloat h, CGFloat s, CGFloat v, CGFloat *r, CGFloat *g, CGFloat *b)
{
	CGFloat alpha;
	UIColor *color = [UIColor colorWithHue:h saturation:s brightness:v alpha:1];
	[color getRed:r green:g blue:b alpha:&alpha];
}


- (void)drawRect:(CGRect)rect
{
    [[UIColor clearColor] setFill];
    UIRectFill(self.bounds);

	CGContextRef contextRef = UIGraphicsGetCurrentContext();
	CGContextSaveGState(contextRef);
	
	CGFloat inset1 = 1.5f;
	CGFloat inset2 = 2.0f;
	CGRect bounds1 = CGRectIntegral(rect);
	CGRect bounds2 = CGRectInset(bounds1, inset1, inset1);
	CGRect bounds3 = CGRectInset(bounds2, inset2, inset2);
    CGFloat radius1 = floorf(bounds1.size.height * 0.25f) + (inset1 + inset2);
    CGFloat radius2 = radius1 - inset1;
    CGFloat radius3 = radius2 - inset2;

	CGFloat h, s, v, a;
	UIColor *baseColor = self.buttonColor;
	[baseColor getHue:&h saturation:&s brightness:&v alpha:&a];
	CGFloat z = (v > 0.5f && self.highlighted) ? 0.2 : 0.0;
	CGFloat v1 = ((v > 0.5f) ? v - 0.3f : v) - z;
	CGFloat v2 = ((v > 0.5f) ? v : v + 0.3f) - z;
	CGFloat r1, g1, b1;
	CGFloat r2, g2, b2;

	// disabled button may should look like it
	CGFloat ss = self.enabled ? s : s * 0.5f;
	HSVtoRGB_(h, ss, v1, &r1, &g1, &b1);
	HSVtoRGB_(h, ss, v2, &r2, &g2, &b2);

	// outer stroke
	CGContextSetRGBStrokeColor(contextRef, 0.5f, 0.5f, 0.5f, 0.125f);
	CGContextSetLineWidth(contextRef, 1.0f);
	CGContextAddPath(contextRef, [self roundRectBezierPath:bounds1 radius:radius1].CGPath);
	CGContextStrokePath(contextRef);

	// inner fill
	CGContextSetRGBFillColor(contextRef, r1, g1, b1, a);
	CGContextAddPath(contextRef, [self roundRectBezierPath:bounds2 radius:radius2].CGPath);
	CGContextFillPath(contextRef);

	// garient fill button
	CGFloat glossiness = 0.25f * (1.0f - fminf(fmaxf(self.gloss, 0.0f), 1.0f)) + 0.01f;
	CGFloat components[] = {		r1, g1, b1, a,
								r1, g1, b1, a,
								r2, g2, b2, a,
								r2, g2, b2, a };
	CGFloat locationsN[4] = {	0.000f,
								0.500f - glossiness,
								0.500f + glossiness,
								1.000f };
	CGFloat locationsH[4] = {	1.000f,
								0.500f + glossiness,
								0.500f - glossiness,
								0.000f };

	CGFloat *locations = self.highlighted ? locationsN : locationsH;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, 4);
	CGPoint startPt = CGRectGetMidXMinYPoint_(bounds1);
	CGPoint endPt = CGRectGetMidXMaxYPoint_(bounds2);

	CGContextAddPath(contextRef, [self roundRectBezierPath:bounds3  radius:radius3].CGPath);
	CGContextClip(contextRef);
	CGContextDrawLinearGradient(contextRef, gradientRef, startPt, endPt, 0);

	CGGradientRelease(gradientRef);
	CGColorSpaceRelease(colorSpaceRef);
	CGContextRestoreGState(contextRef);
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.contentMode = UIViewContentModeRedraw;
}

@end
