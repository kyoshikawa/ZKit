//
//  ZManagedObjectStorage.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 4/24/13.
//  Copyright (c) 2013 Electricwoods LLC. All rights reserved.
//

#import "ZManagedObjectStorage.h"
#import "ZAlertView.h"
#import "ZAction.h"
#import "ZUtils.h"

//
//	ZManagedObjectStorage ()
//

@interface ZManagedObjectStorage ()
{
	NSManagedObjectContext *_managedObjectContext;
	NSManagedObjectModel *_managedObjectModel;
	NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@end


//
//	ZManagedObjectStorage
//

@implementation ZManagedObjectStorage

- (id)initWithStorageFile:(NSString *)file modelName:(NSString *)modelName
{
	if (self = [super init]) {
		NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
		_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	    NSURL *storeURL = [NSURL fileURLWithPath:file];
		NSError *error = nil;
		_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
		if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
			#if DEBUG
			NSLog(@"CoreData: Unresolved error %@, %@", error, [error userInfo]);
			[[NSFileManager defaultManager] removeItemAtPath:file error:&error];
			ZReportError(error);
		
			ZAction *okAction = [ZAction actionWithTitle:@"OK" target:nil action:nil object:nil];
			[[[ZAlertView alloc] initWithTitle:@"Debug" message:@"Failed migrating Core Data Model. Old file will be deleted under debug version." cancelAction:okAction otherActions:nil] show];
			
			_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
			if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
				NSLog(@"Failed to re-create new document file: %@", error);
				abort();
			}
			#endif
		}
		_managedObjectContext = [[NSManagedObjectContext alloc] init];
		[_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
	}
	return self;
}


- (NSManagedObjectContext *)managedObjectContext
{
    return _managedObjectContext;
}

- (void)save
{
	NSError *error = nil;
	[self.managedObjectContext save:&error];
	ZReportError(error);
}

@end
