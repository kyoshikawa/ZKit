//
//  ZManagedObjectStorage.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 4/24/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


//
//	ZManagedObjectStorage
//

@interface ZManagedObjectStorage : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (id)initWithStorageFile:(NSString *)file modelName:(NSString *)modelName;
- (void)save;

@end
