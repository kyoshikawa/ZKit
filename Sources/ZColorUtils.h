//
//  ZColorUtils.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 12/31/09.
//  Copyright 2009 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __RGBA_t__
#define __RGBA_t__
typedef struct ZRGBA
{
	CGFloat r;
	CGFloat g;
	CGFloat b;
	CGFloat a;
} ZRGBA;
#endif

#ifndef __HSVA_t__
#define __HSVA_t__
typedef struct ZHSVA
{
	CGFloat h;
	CGFloat s;
	CGFloat v;
	CGFloat a;
} ZHSVA;
#endif

enum ZColorModel
{
	ZColorModelUnknown,
	ZColorModelHSV,
	ZColorModelRGB
};
typedef enum ZColorModel ZColorModel;


extern void RGBtoHSV(CGFloat r, CGFloat g, CGFloat b, CGFloat *h, CGFloat *s, CGFloat *v);
extern void HSVtoRGB(CGFloat h, CGFloat s, CGFloat v, CGFloat *r, CGFloat *g, CGFloat *b);
extern void CGColorToRGBA(CGColorRef colorRef, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a);
extern void CGColorToHSV(CGColorRef colorRef, CGFloat *h, CGFloat *s, CGFloat *v, CGFloat *a);
extern void CGColorToRGBA8(CGColorRef colorRef, unsigned char *r, unsigned char *g, unsigned char *b, unsigned char *a);
extern CGColorRef CGColorFromZRGBA(ZRGBA rgba);
extern CGColorRef CGColorFromZHSVA(ZHSVA hsva);
extern UIColor *UIColorFromZRGBA(ZRGBA rgba);
extern ZRGBA ZRGBAFromCGColor(CGColorRef colorRef);
extern ZHSVA ZHSVAFromCGColor(CGColorRef colorRef);
extern ZRGBA ZRGBAFromRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
extern ZRGBA ZRGBAFromHSV(CGFloat h, CGFloat s, CGFloat v, CGFloat a);
extern ZHSVA ZHSVAFromRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
extern ZRGBA ZRGBAFromZHSVA(ZHSVA hsva);
extern ZHSVA ZHSVAFromZRGBA(ZRGBA rgba);
extern bool ZRGBAEqualToZRGBA(ZRGBA rgba1, ZRGBA rgba2);
extern NSValue *ZRGBAValue(ZRGBA rgba);
extern ZRGBA ZRGBAFromValue(NSValue *aValue);
extern ZRGBA interpolateZRGBA(ZRGBA a1, ZRGBA a2, CGFloat a);
extern ZRGBA ZRGBAMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
extern ZRGBA ZRGBAFromString(NSString *aString);
extern void CGContextSetHSVStrokeColor_(CGContextRef context, CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha);
extern void CGContextSetHSVFillColor_(CGContextRef context, CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha);


#ifdef __cplusplus
}
#endif
