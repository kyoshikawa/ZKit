//
//  NSDate+Z.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/03/08.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "NSDate+Z.h"


@implementation NSDate (Z)

- (NSString *)shortDateTimeString
{
	return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)mediumDateTimeString
{
	return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *)longDateTimeString
{
	return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
}


- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)aDateStyle timeStyle:(NSDateFormatterStyle)aTimeStyle
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
	dateFormatter.dateStyle = aDateStyle;
	dateFormatter.timeStyle = aTimeStyle;
	return [dateFormatter stringFromDate:self];
}

- (NSString *)yearMonthString
{
	NSDateFormatter *yearMonthFormatter = [[NSDateFormatter alloc] init];
	yearMonthFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	[yearMonthFormatter setDateFormat:@"yyyy-MM"];
	NSString *string = [yearMonthFormatter stringFromDate:self];
	return string;
}
@end
