//
//  NSSet+Z.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/08/01.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import "NSSet+Z.h"


@implementation NSSet (Z)

- (NSSet *)setByRemovingObjectsFromSet:(NSSet *)aSet
{
	NSMutableSet *anotherSet = [NSMutableSet setWithSet:self];
	[anotherSet minusSet:aSet];
	return anotherSet;
}

- (NSSet *)setByRemovingObjectsFromArray:(NSArray *)aArray
{
	NSMutableSet *anotherSet = [NSMutableSet setWithSet:self];
	[anotherSet removeObjectsFromArray:aArray];
	return anotherSet;
}

- (NSSet *)setByRemovingObject:(id)aObject
{
	NSMutableSet *anotherSet = [NSMutableSet setWithSet:self];
	[anotherSet removeObject:aObject];
	return anotherSet;
}

- (NSSet *)setByIntersectSet:(NSSet *)aSet
{
	NSMutableSet *anotherSet = [NSMutableSet setWithSet:self];
	[anotherSet intersectSet:aSet];
	return anotherSet;
}

- (NSArray *)sortedArrayUsingDescriptor:(NSSortDescriptor *)sortDescriptor;
{
	return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSArray *)sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;
{
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

@end


@implementation NSMutableSet (Z)

- (void)addObjectsFromSet:(NSSet *)objects
{
	[self unionSet:objects];
}

- (void)removeObjectsFromSet:(NSSet *)objects
{
	[self minusSet:objects];
}

- (void)removeObjectsFromArray:(NSArray *)objects
{
	[self minusSet:[NSSet setWithArray:objects]];
}

- (void)addObjectIfNotNil:(id)aObject
{
	if (aObject) {
		[self addObject:aObject];
	}
}

- (void)removeObjectIfNotNil:(id)aObject
{
	if (aObject) {
		[self removeObject:aObject];
	}
}

@end
