//
//  RootViewControllerTests.m
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 28/08/2010.
//  Copyright 2010 Unboxed Consulting. All rights reserved.
//

/***********************************************************************************************/
/* This test suit tests the some of the most basic methods in a TableViewController. It's	   */
/* an example. More tests could be implemented to test the rest of the methods.				   */
/*																							   */
/* This two tests are implemented as application tests aswell, but they are typical logic tests*/
/* as they don't need the views and their infrastructure (nib) to work.						   */
/***********************************************************************************************/		

#import "RootViewControllerTests.h"

@interface RootViewControllerTests(helpers)
- (void)insertNewNote: (NSFetchedResultsController*) frc withText:(NSString*) text;
- (void)insertNewNoteInContext: (NSManagedObjectContext*) cntx andDate: (NSDate*) date;
- (NSFetchedResultsController*) mockFetchResultController: (NSManagedObjectContext*) context;
- (void)insertNewObject: (NSFetchedResultsController*) frc;
- (void) deleteNotes: (NSManagedObjectContext*) context fetchController:(NSFetchedResultsController*) frc;
@end

@implementation RootViewControllerTests


- (void) setUp
{	
	coreDataStackHelper = [[CoreDataStackHelper alloc] initWithPersitentStoreType: NSInMemoryStoreType];	
	rootController = [[RootViewController alloc] init];
	testsHelper = [[TestHelpers alloc] init];
}


- (void) tearDown
{	
	[rootController release];
	[coreDataStackHelper release];
	[testsHelper release];
	NSLog(@"\n###############################################################################");
}

- (void) testNumberOfSectionsInTableView
{
	NSLog(@"\n\n#################### testNumberOfSectionsInTableView ####################");	
	/***********************************************************************************************/
	/* We want the table to have 1 section (this could be implemented as a logic test)			   */
	/*																							   */
	/* Because this TableViewcontroller delegate method uses NSFetchedResultsController which	   */
	/* accesses the Context model	(which for instance uses NSSearchPathForDirectoriesInDomains   */
	/* that accesses directories) There were problems accessing directories in a logic test.	   */
	/* I had to make it an application test.													   */
	/***********************************************************************************************/		
	
	// Mock dependencies.
	NSFetchedResultsController* frc;
	NSManagedObjectContext* context = coreDataStackHelper.managedObjectContext;	
	rootController.fetchedResultsController = [testsHelper mockFetchResultController: context];
	frc = rootController.fetchedResultsController;	
	
	NSInteger expected = [[frc sections] count];
	NSInteger got = [rootController numberOfSectionsInTableView: rootController.tableView];
	
	STAssertTrue(expected == got, @"The value returned by numberOfSectionsInTableView was %i, expected %i.", got, expected);
}


- (void) testNumberOfRowsInTableView
{
	NSLog(@"\n\n#################### testNumberOfRowsInTableView ####################");	
	/***********************************************************************************************/
	/* (this could be implemented as a logic test)												   */
	/* We want the table to have as many rows as results are in the array that the				   */
	/* fetchedResultsController has.															   */
	/***********************************************************************************************/						
	
	// Mock dependencies.
	NSManagedObjectContext* context = [coreDataStackHelper managedObjectContext];
	NSFetchedResultsController* frc = [testsHelper mockFetchResultController: context];	
	rootController.fetchedResultsController = frc;
	rootController.managedObjectContext = context;
	
	// Create test data
	[testsHelper deleteNotes:context fetchController:frc];
	[testsHelper insertNewNoteInContext:context andDate: [NSDate date]];
	[testsHelper insertNewNoteInContext:context andDate: [NSDate dateWithTimeIntervalSinceNow:5]];
	[testsHelper insertNewNoteInContext:context andDate: [NSDate dateWithTimeIntervalSinceNow:10]];	
	
	NSInteger expected = 3;
	NSInteger got = [rootController tableView:rootController.tableView numberOfRowsInSection:0];
	
	STAssertTrue(expected==got, @"incorrect number of rows for section 0. Expected: %i, Got: %i", expected, got);	
}

@end
