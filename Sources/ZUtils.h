//
//  ZUtils.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/02/04.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//	ZUtils
//


#ifdef __cplusplus
extern "C" {
#endif


//	These work just like assert(false), but useful for ternary operator.
//	Usage:
//		NSString *message = (i==0) ? @"Left" : (i==1) ? @"Right" : ZUnexpectedString(@"Something is wrong");
//
#if DEBUG
#define ZUnexpectedInteger(value) ZUnexpectedInteger_(value, __FILE__, __LINE__)
#define ZUnexpectedFloat(value) ZUnexpectedFloat_(value, __FILE__, __LINE__)
#define ZUnexpectedString(value) ZUnexpectedString_(value, __FILE__, __LINE__)
#else
#define ZUnexpectedInteger(value) ((NSInteger)value)
#define ZUnexpectedFloat(value) ((float)value)
#define ZUnexpectedString(value) ((NSString *)value)
#endif

extern NSString *ZApplicationIdentifier(void);
extern NSString *ZApplicationVersion(void);
extern BOOL NSObjectEqualToObject(NSObject *object1, NSObject *object2);
extern BOOL NSDataEqualToData(NSData *data1, NSData *data2);
extern BOOL NSStringEqualToString(NSString *string1, NSString *string2);
extern BOOL NSArrayEqualToArray(NSArray *array1, NSArray *array2);
extern BOOL NSSetEqualToSet(NSSet *set1, NSSet *set2);
extern BOOL NSDictionaryEqualToDictionary(NSDictionary *dictionary1, NSDictionary *dictionary2);
extern BOOL NSNumberEqualToNumber(NSNumber *number1, NSNumber *number2);
extern BOOL NSValueEqualToValue(NSValue *value1, NSValue *value2);
extern BOOL NSDateEqualToDate(NSDate *date1, NSDate *date2);
extern void ZReportError(NSError *error);
extern NSString *ZDocumentDirectory(void);
extern NSString *ZLibraryDirectory(void);
extern NSString *ZCachesDirectory(void);
extern NSURL *ZDocumentDirectoryURL(void);
extern NSURL *ZCachesDirectoryURL(void);
extern BOOL ZFilePathEqualToFilePath(NSString *aPath1, NSString *aPath2);
extern NSString *NSStringFromBool(BOOL value);
extern NSRange NSRangeFromCFRange(CFRange range);
extern CFRange CFRangeFromNSRange(NSRange range);
#if DEBUG
extern NSInteger ZUnexpectedInteger_(NSInteger value, const char *file, int line);
extern float ZUnexpectedFloat_(float value, const char *file, int line);
extern NSString *ZUnexpectedString_(NSString *value, const char *file, int line);
#endif



#ifdef __cplusplus
}
#endif


