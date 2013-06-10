//
//  NSSet+Z.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/08/01.
//  Copyright 2010 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSSet (Z)

- (NSSet *)setByRemovingObjectsFromSet:(NSSet *)aSet;
- (NSSet *)setByRemovingObjectsFromArray:(NSArray *)aArray;
- (NSSet *)setByRemovingObject:(id)aObject;
- (NSSet *)setByIntersectSet:(NSSet *)aSet;
- (NSArray *)sortedArrayUsingDescriptor:(NSSortDescriptor *)sortDescriptor;
- (NSArray *)sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;
@end


@interface NSMutableSet (Z)

- (void)addObjectsFromSet:(NSSet *)objects;
- (void)removeObjectsFromSet:(NSSet *)objects;
- (void)removeObjectsFromArray:(NSArray *)objects;
- (void)addObjectIfNotNil:(id)aObject;
- (void)removeObjectIfNotNil:(id)aObject;

@end

