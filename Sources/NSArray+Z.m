//
//  NSArray+Z.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 11/02/04.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "NSArray+Z.h"


//
//	NSArray (Z)
//
@implementation NSArray (Z)

- (NSArray *)arrayByRemovingObject:(id)aObject
{
	NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
	[newArray removeObject:aObject];
	return newArray;
}

- (NSArray *)arrayByRemovingObjectsFromArray:(NSArray *)aObjects
{
	NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
	for (id object in aObjects) {
		[newArray removeObject:object];
	}
	return newArray;
}

- (NSArray *)arrayByRemovingObjectsFromSet:(NSSet *)aObjects;
{
	NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
	for (id object in aObjects) {
		[newArray removeObject:object];
	}
	return newArray;
}

- (NSArray *)arrayByAddingObjectsFromSet:(NSSet *)aObjects;
{
	NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
	for (id object in aObjects) {
		[newArray addObject:object];
	}
	return newArray;
}

- (NSArray *)arrayByInsertingObjects:(NSArray *)aObjects atIndex:(NSUInteger)aIndex
{
	NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
	[newArray insertObjects:aObjects atIndex:aIndex];
	return newArray;
}

- (id)firstObject
{
	return ([self count] > 0) ? [self objectAtIndex:0] : nil;
}

- (NSArray *)sortedArrayUsingSortDescriptor:(NSSortDescriptor *)sortDescriptor;
{
	return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSArray *)sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;
{
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSArray *)reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end


//
//	NSMutableArray (Z)
//
@implementation NSMutableArray (Z)

- (void)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
	if (toIndex != fromIndex) {
		id object = [self objectAtIndex:fromIndex];
		[self removeObjectAtIndex:fromIndex];
		if (toIndex >= [self count]) {
			[self addObject:object];
		}
		else {
			[self insertObject:object atIndex:toIndex];
		}
	}
}

- (void)removeObjectsInSet:(NSSet *)aSet
{
	for (id object in aSet) {
		[self removeObject:object];
	}
}

- (void)insertObjects:(NSArray *)aObjects atIndex:(NSUInteger)aIndex
{
	[self insertObjects:aObjects atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(aIndex, [aObjects count])]];
}

- (void)addObjectIfNotNil:(id)aObject
{
	if (aObject) {
		[self addObject:aObject];
	}
}

@end