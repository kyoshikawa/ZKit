//
//  ZCalendarDate.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/27/12.
//  Copyright (c) 2012 Electricwoods LLC. All rights reserved.
//

#import "ZCalendarDate.h"


//
//	ZCalendarYear
//

@implementation ZCalendarYear

- (id)initWithYear:(NSInteger)year
{
	if (self = [super init]) {
		self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		self.year = year;
	}
	return self;
}

- (void)dealloc
{
    self.calendar = nil;
}

- (ZCalendarMonth *)calendarMonth:(NSInteger)month
{
	return [ZCalendarMonth calendarMonth:month year:self.year];
}

- (BOOL)isEqual:(ZCalendarYear *)object
{
	if ([object isKindOfClass:[ZCalendarYear class]]) {
		return (self.year == object.year);
	}
	return NO;
}

@end


//
//	ZCalendarMonth
//

@implementation ZCalendarMonth

+ (ZCalendarMonth *)thisMonth
{
	return [ZCalendarMonth calendarMonthWithDate:[NSDate date]];
}

+ (ZCalendarMonth *)calendarMonthWithDate:(NSDate *)date
{
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *componets = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:date];
	return [[ZCalendarMonth alloc] initWithMonth:componets.month year:componets.year];
}

+ (id)calendarMonth:(NSInteger)month year:(NSInteger)year;
{
	return [[ZCalendarMonth alloc] initWithMonth:month year:year];
}

- (id)initWithMonth:(NSInteger)month year:(NSInteger)year;
{
	if (self = [super initWithYear:year]) {
		self.month = month;
	}
	return self;
}

- (BOOL)isEqual:(ZCalendarDate *)object
{
	if ([object isKindOfClass:[ZCalendarMonth class]]) {
		return (self.month == object.month && self.year == object.year);
	}
	return NO;
}

- (ZCalendarDate *)calendarDateWithDay:(NSInteger)day;
{
	return [ZCalendarDate calendarDateWithDay:day month:self.month year:self.year];
}

- (ZCalendarDate *)firstCalendarDateOfMonth
{
	return [ZCalendarDate calendarDateWithDay:1 month:self.month year:self.year];
}

- (NSInteger)daysInMonth
{
	NSDateComponents *firstDayOfMonthComponents = [[NSDateComponents alloc] init];
	[firstDayOfMonthComponents setYear:self.year];
	[firstDayOfMonthComponents setMonth:self.month];
	[firstDayOfMonthComponents setDay:1];
	NSDate *firstDayOfMonth = [self.calendar dateFromComponents:firstDayOfMonthComponents];

	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setMonth:1];
	[offsetComponents setDay:-1];
	NSDate *lastDayOfMonth = [self.calendar dateByAddingComponents:offsetComponents toDate:firstDayOfMonth options:0];

	NSDateComponents *lastDayComponents = [self.calendar components:NSDayCalendarUnit fromDate:lastDayOfMonth];
	return [lastDayComponents day];
}

- (NSDateComponents *)dateComponents
{
	NSDateComponents *componets = [[NSDateComponents alloc] init];
	componets.year = self.year;
	componets.month = self.month;
	return componets;
}

- (NSDate *)date
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.year = self.year;
	components.month = self.month;
	components.day = 1;
	return [self.calendar dateFromComponents:components];
}

- (ZCalendarMonth *)calendarMonthOffsetByMonths:(NSInteger)months
{
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	offsetComponents.month = months;
	NSDate *date = [self.calendar dateByAddingComponents:offsetComponents toDate:self.date options:0];
	NSDateComponents *components = [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:date];
	return [ZCalendarMonth calendarMonth:components.month year:components.year];
}

- (ZCalendarMonth *)previousCalendarMonth
{
	return [self calendarMonthOffsetByMonths:-1];
}

- (ZCalendarMonth *)nextCalendarMonth
{
	return [self calendarMonthOffsetByMonths:+1];
}

@end


//
//	ZCalendarDay
//

@implementation ZCalendarDate


+ (ZCalendarDate *)today
{
	return [ZCalendarDate calendarDateFromDate:[NSDate date]];
}

+ (ZCalendarDate *)calendarDateFromDate:(NSDate *)date
{
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
	return [ZCalendarDate calendarDateWithDay:components.day month:components.month year:components.year];
}

+ (id)calendarDateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
{
	return [[ZCalendarDate alloc] initWithDay:day month:month year:year];
}

- (id)initWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
{
	if (self = [super initWithMonth:month year:year]) {
		self.year = year;
		self.month = month;
		self.day = day;
	}
	return self;
}

- (id)initWithInteger:(NSInteger)integerValue
{
	NSInteger value = integerValue;
	NSInteger dd = value % 100; value /= 100;
	NSInteger mm = value % 100; value /= 100;
	NSInteger yyyy = value;
	if (self = [self initWithDay:dd month:mm year:yyyy]) {
	}
	return self;
}

- (NSInteger)integerValue
{
	NSInteger value = self.year * 10000 + self.month * 100 + self.day;
	return value;
}

- (BOOL)isEqual:(ZCalendarDate *)object
{
	if ([object isKindOfClass:[ZCalendarDate class]]) {
		return (self.day == object.day && self.month == object.month && self.year == object.year);
	}
	return NO;
}

- (NSDate *)date
{
	return [self.calendar dateFromComponents:self.dateComponents];
}

- (NSDateComponents *)dateComponents
{
	NSDateComponents *componets = [[NSDateComponents alloc] init];
	componets.year = self.year;
	componets.month = self.month;
	componets.day = self.day;
	return componets;
}

- (NSInteger)weekday
{
	NSDateComponents *components = [self.calendar components:NSWeekdayCalendarUnit fromDate:self.date];
	return components.weekday;
}

- (ZCalendarDate *)firstCalendarDayOfYear
{
	return [ZCalendarDate calendarDateWithDay:1 month:1 year:self.year];
}

- (ZCalendarDate *)firstCalendarDayOfMonth
{
	return [ZCalendarDate calendarDateWithDay:1 month:self.month year:self.year];
}

- (ZCalendarDate *)firstCalendarDateOfWeek
{
	// i.e. first weekday of September 1, 2012 is August 26 (Sun)
	//		(September 2012)
	//		26	27	28	29	30	31	 1
	//		 2	 3	 4	 5	 6	 7	 8
	//		...
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	offsetComponents.day = 1-self.weekday;
	NSDate *date = [self.calendar dateByAddingComponents:offsetComponents toDate:self.date options:0];
	return [ZCalendarDate calendarDateFromDate:date];
}

- (ZCalendarDate *)calendarDateOffsetByDays:(NSInteger)days
{
	NSDateComponents *offsetComponets = [[NSDateComponents alloc] init];
	offsetComponets.day = days;
	NSDate *date = [self.calendar dateByAddingComponents:offsetComponets toDate:self.date options:0];
	return [ZCalendarDate calendarDateFromDate:date];
}

- (ZCalendarDate *)calendarDateOffsetByMonth:(NSInteger)months
{
	NSDateComponents *offsetComponets = [[NSDateComponents alloc] init];
	offsetComponets.month = months;
	NSDate *date = [self.calendar dateByAddingComponents:offsetComponets toDate:self.date options:0];
	return [ZCalendarDate calendarDateFromDate:date];
}

- (ZCalendarDate *)previousCalendarDate
{
	return [self calendarDateOffsetByDays:-1];
}

- (ZCalendarDate *)nextCalendarDate
{
	return [self calendarDateOffsetByDays:+1];
}

@end
