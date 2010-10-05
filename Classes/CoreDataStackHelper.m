//
//  CoreDataStackHelper.m
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 30/08/2010.
//  Copyright 2010 Unboxed Consulting. All rights reserved.
//

#import "CoreDataStackHelper.h"

@interface CoreDataStackHelper(private)
- (NSPersistentStoreCoordinator*) createInMemoryPersistentStoreCoordinator;
- (NSPersistentStoreCoordinator*) createSQLPersistentStoreCoordinator;
@end



@implementation CoreDataStackHelper

@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;
@synthesize storeType;

- (id) init
{
	/*************************************************************************************************/
	/* Default init, calls init with 'NSInMemoryStoreType' as the default parameter.				 */
	/*************************************************************************************************/
	
	if (self = [self initWithPersitentStoreType:NSInMemoryStoreType])
	{
		
	}
	
	return self;
}


- (id) initWithPersitentStoreType: (NSString*) sType
{
	/*************************************************************************************************/
	/* Custom init, with a parameter to define the type of the persistence store.					 */
	/*************************************************************************************************/	
	if(self = [super init])
	{
		[self setStoreType: sType];
	}
	
	return self;
}


- (NSManagedObjectContext*) managedObjectContext
{
	/*************************************************************************************************/
	/* Returns the managed object context for the application. If the context doesn't already exist, */
	/* it is created and bound to the persistent store coordinator for the application.				 */
	/*************************************************************************************************/		
    if (managedObjectContext != nil)
	{
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
	{
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}


- (NSManagedObjectModel*) managedObjectModel
{
	/*************************************************************************************************/
	/* Returns the managed object model for the application. If the model doesn't already exist,	 */
	/* it is created from the application's model.													 */
	/*************************************************************************************************/		
    if (managedObjectModel != nil)
	{
        return managedObjectModel;
    }
	
    NSString* modelPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"I_will_test_my_apps" ofType:@"momd"];	
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

	
    return managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	/*************************************************************************************************/
	/* Returns the persistent store coordinator for the application.If the coordinator doesn't       */
	/* already exist, it is created and the application's store added to it							 */
	/*************************************************************************************************/
	
    if (persistentStoreCoordinator != nil)
	{
        return persistentStoreCoordinator;
    }
    
	if([storeType isEqualToString: NSInMemoryStoreType])
	{
		persistentStoreCoordinator = [self createInMemoryPersistentStoreCoordinator];
	}
	
	if([storeType isEqualToString: NSSQLiteStoreType])
	{
		persistentStoreCoordinator = [self createSQLPersistentStoreCoordinator];
	}
	    
    return persistentStoreCoordinator;
}


- (NSPersistentStoreCoordinator*) createInMemoryPersistentStoreCoordinator
{
	/*************************************************************************************************/
	/* Helper method to create a in memory persistent store coordinator.							 */
	/*************************************************************************************************/	
    NSError* error = nil;
    NSPersistentStoreCoordinator* storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
    if (![storeCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration: nil URL: nil options:nil error: &error])
	{
		// Add real error handling code
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
	
	return storeCoordinator;	
}


- (NSPersistentStoreCoordinator*) createSQLPersistentStoreCoordinator
{
	/*************************************************************************************************/
	/* Helper method to create a database based persistent store coordinator.						 */
	/*************************************************************************************************/		
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"I_will_test_my_apps.sqlite"]];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator* storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
    if (![storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
	{
		// Add real error handling code
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
	
	return storeCoordinator;
}


- (NSString *)applicationDocumentsDirectory
{
	/*************************************************************************************************/
	/* Returns the path to the application's Documents directory.									 */
	/*************************************************************************************************/			
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (void) dealloc
{
	/*************************************************************************************************/
	/* Tidy-up.																						 */
	/*************************************************************************************************/				
	managedObjectModel = nil;
	managedObjectContext = nil;
	persistentStoreCoordinator = nil;
	self.storeType = nil;
	
	[super dealloc];
	
}

@end
