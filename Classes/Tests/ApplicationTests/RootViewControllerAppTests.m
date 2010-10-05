//
//  RootViewControllerAppTests.m
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 28/08/2010.
//  Copyright 2010 Unboxed Consulting. All rights reserved.


/***********************************************************************************************/
/* This test suit tests the some of the most basic methods in a TableViewController. It's	   */
/* an example. More tests could be implemented to test the rest of the methods.				   */
/*																							   */
/* Because the table view controller ultimately takes its data from the CoreData stack		   */
/* this tests use an in-memory  persintent store to 'mock' the persistence stack.			   */
/***********************************************************************************************/		

#import "RootViewControllerAppTests.h"
#import "TestHelpers.h"


@implementation RootViewControllerAppTests

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


- (void) testCellTextIsUsingTextProperty
{
	NSLog(@"\n#################### testCellTextIsUsingTextProperty ####################");	
	/***********************************************************************************************/
	/* We want the table to have as many rows as results are in the array that the				   */
	/* fetchedResultsController has.															   */
	/* Here, we're testing that the cells are set up correctly. In this case we only care about    */
	/* the text.																				   */
	/***********************************************************************************************/						

	// Mock dependencies
	NSManagedObjectContext* context = [coreDataStackHelper managedObjectContext];
	NSFetchedResultsController* frc = [testsHelper mockFetchResultController: context];	
	RootViewController* controller = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle bundleForClass:[self class]]];
	controller.managedObjectContext = context;
	controller.fetchedResultsController = frc;
	
	// Create test Data
	NSDate* sooner = [NSDate date];
	NSDate* later = [NSDate dateWithTimeIntervalSinceNow:5];	
	[testsHelper deleteNotes:context fetchController:frc];
	[testsHelper insertNewNoteInContext:context andDate: later];
	[testsHelper insertNewNoteInContext:context andDate: sooner];
	 
	// Get the cells
	NSIndexPath* indexPath_0 = [NSIndexPath indexPathForRow:0 inSection:0];
	NSIndexPath* indexPath_1 = [NSIndexPath indexPathForRow:1 inSection:0];
	UITableViewCell* cell0 = [controller tableView: controller.tableView cellForRowAtIndexPath: indexPath_0];	
	UITableViewCell* cell1 = [controller tableView: controller.tableView cellForRowAtIndexPath: indexPath_1];
			
	STAssertTrue([[[cell0 textLabel] text] isEqualToString: [later description]], @"Expected content of cell 0 to have text: '%@', found: %@",[later description], [[cell0 textLabel] text]);
	STAssertTrue([[[cell1 textLabel] text] isEqualToString: [sooner description]], @"Expected content of cell 1 to have text: '%@', found: %@",[sooner description], [[cell1 textLabel] text]);
}


- (void) testCommitEditingStyle_deleteRow
{
	NSLog(@"\n\n#################### testCommitEditingStyle_deleteRow ####################");
	/***********************************************************************************************/
	/* Whe are testing the CommitEditingStyle delegate.											   */
	/***********************************************************************************************/						
	
	// Mock dependencies
	NSManagedObjectContext* context = [coreDataStackHelper managedObjectContext];
	NSFetchedResultsController* frc = [testsHelper mockFetchResultController: context];
	RootViewController* controller = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle bundleForClass:[self class]]];
	controller.managedObjectContext = context;
	controller.fetchedResultsController = frc;
	
	// Create test data
	NSDate* sooner = [NSDate date];
	NSDate* later = [NSDate dateWithTimeIntervalSinceNow:5];	
	[testsHelper deleteNotes:context fetchController:frc];
	[testsHelper insertNewNoteInContext:context andDate: later];
	[testsHelper insertNewNoteInContext:context andDate: sooner];
		
	[controller tableView: controller.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	NSInteger expected = 1;
	NSInteger got = [controller tableView:rootController.tableView numberOfRowsInSection:0];
	
	STAssertTrue(expected==got, @"incorrect number of rows for section 0. Expected: %i, Got: %i", expected, got);
}


@end
