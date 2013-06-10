//
//  ZCalendarDate.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/27/12.
//  Copyright (c) 2012 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCalendarYear;
@class ZCalendarMonth;
@class ZCalendarDate;

enum {
	ZUndefinedDateComponent = NSUndefinedDateComponent,
};


typedef enum {
	ZWeekdaySunday = 1,
	ZWeekdayMonday = 2,
	ZWeekdayTuesday = 3,
	ZWeekdayWednesday = 4,
	ZWeekdayThrusday = 5,
	ZWeekdayFriday = 6,
	ZWeekdaySaterday = 7
} ZWeekday;


//
//	ZCalendarDate
//

@protocol ZCalendarDate <NSObject>

@end


//
//	ZCalendarYear
//

@interface ZCalendarYear : NSObject <ZCalendarDate>

@property (strong) NSCalendar *calendar;
@property (assign) NSInteger year;

- (id)initWithYear:(NSInteger)year;
- (ZCalendarMonth *)calendarMonth:(NSInteger)month;

@end


//
//	ZCalendarMonth
//

@interface ZCalendarMonth : ZCalendarYear

@property (assign) NSInteger month;				// 1...12

+ (ZCalendarMonth *)thisMonth;
+ (ZCalendarMonth *)calendarMonthWithDate:(NSDate *)date;
+ (id)calendarMonth:(NSInteger)month year:(NSInteger)year;
- (id)initWithMonth:(NSInteger)month year:(NSInteger)year;
- (ZCalendarDate *)calendarDateWithDay:(NSInteger)daye;
- (ZCalendarDate *)firstCalendarDateOfMonth;
- (ZCalendarMonth *)calendarMonthOffsetByMonths:(NSInteger)months;
- (ZCalendarMonth *)previousCalendarMonth;
- (ZCalendarMonth *)nextCalendarMonth;
- (NSInteger)daysInMonth;


@end


//
//	ZCalendarDate
//

@interface ZCalendarDate : ZCalendarMonth

@property (assign) NSInteger day;				// 1...31

+ (id)today;
+ (ZCalendarDate *)calendarDateFromDate:(NSDate *)date;
+ (id)calendarDateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;
- (ZCalendarDate *)calendarDateOffsetByDays:(NSInteger)days;
- (ZCalendarDate *)calendarDateOffsetByMonth:(NSInteger)months;
- (id)initWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;
- (id)initWithInteger:(NSInteger)integerValue;
- (NSInteger)integerValue;

- (NSDate *)date;

- (ZCalendarDate *)firstCalendarDayOfYear;
- (ZCalendarDate *)firstCalendarDayOfMonth;
- (ZCalendarDate *)firstCalendarDateOfWeek;

- (ZCalendarDate *)previousCalendarDate;
- (ZCalendarDate *)nextCalendarDate;

//- (ZCalendarDate *)previousMonth;
//- (ZCalendarDate *)nextMonth;
//- (ZCalendarDate *)previousYear;
//- (ZCalendarDate *)nextYear;

- (NSInteger)weekday;


@end
