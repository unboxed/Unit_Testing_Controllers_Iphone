//
//  TestHelpers.m
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 04/10/2010.
//  Copyright 2010 Unboxed Consulting. All rights reserved.
//

#import "TestHelpers.h"
#import <CoreData/CoreData.h>
#import "RootViewControllerAppTests.h"
#import "RootViewController.h"
#import "I_will_test_my_appsAppDelegate.h"
#import <CoreData/CoreData.h>
#import "CoreDataStackHelper.h"



@implementation TestHelpers

- (NSFetchedResultsController*) mockFetchResultController: (NSManagedObjectContext*) context
{
	/**************************************************************************************************/
	/* For the tests to work the cache name needs to be nil.										  */
	/* Use this class so you can test Controller, and not worry about the dependencies.				  */
	/**************************************************************************************************/
	
    //Set the request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController* aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
																								managedObjectContext:context 
																								  sectionNameKeyPath:nil 
																										   cacheName:nil]; // for the tests to work the cache name needs to be nil
    aFetchedResultsController.delegate = self;
	// Tidy-up
    [aFetchedResultsController autorelease];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error])
	{
        NSLog(@"Unresolved error performing fetch in mockFetchResultController. %@, %@", error, [error userInfo]);
        abort();
    }
	
	return aFetchedResultsController;
}


- (void)insertNewNoteInContext: (NSManagedObjectContext*) cntx andDate: (NSDate*) date
{
	/**************************************************************************************************/
	/* Helper method to add test data to the data store.											  */
	/**************************************************************************************************/
	
	NSManagedObject* newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:cntx];    
    [newManagedObject setValue: date  forKey:@"created_at"];
	[newManagedObject setValue: [date description] forKey:@"text"];
    
    // Save the context.
    NSError *error = nil;
    if (![cntx save:&error])
	{
        NSLog(@"Unresolved error inserting note in context %@, %@", error, [error userInfo]);
        abort();
    }
	else
	{
		 NSLog(@"Successfully inserted note into context");
	}	
}


- (void) deleteNotes: (NSManagedObjectContext*) context fetchController:(NSFetchedResultsController*) frc
{
	/**************************************************************************************************/
	/* Helper Method to delete all the notes in the data store.										  */
	/**************************************************************************************************/
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[frc sections] objectAtIndex:0];
	
	for(int i=0; i<[sectionInfo numberOfObjects]; i++)
	{
		[context deleteObject:[frc objectAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];	
	}
	
	// Save the context.
	NSError *error = nil;
	if (![context save:&error])
	{
		NSLog(@"Unresolved error deleting notes %@, %@", error, [error userInfo]);
		abort();
	}	
	else
	{
		NSLog(@"Successfully inserted note into context");
	}	
	
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
	// This makes  testNumberOfRowsInTableView work. Don't know why, if it's not here, it fails
}

@end
