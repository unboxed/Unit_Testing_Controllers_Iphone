//
//  CoreDataStackHelper.h
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 30/08/2010.
//  Copyright 2010 Unboxed Consulting. All rights reserved.
//

// This class intends to be a generic entry point to the CoreData Stack. No more accessing the context through
// the application delegate.


#import <CoreData/CoreData.h>

@interface CoreDataStackHelper : NSObject
{
	
@private
    NSManagedObjectContext*        managedObjectContext;
    NSManagedObjectModel*          managedObjectModel;
    NSPersistentStoreCoordinator*  persistentStoreCoordinator;
	NSString*                      storeType;	
}

@property (nonatomic, retain, readonly) NSManagedObjectContext*        managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel*          managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator*  persistentStoreCoordinator;
@property (nonatomic, retain)           NSString*					   storeType;


- (id) initWithPersitentStoreType: (NSString*) sType;
- (NSManagedObjectContext *)managedObjectContext;
- (NSString *)applicationDocumentsDirectory;

@end
