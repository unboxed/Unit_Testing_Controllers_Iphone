//
//  RootViewControllerAppTests.h
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 28/08/2010.
//  Copyright 2010 Unboxed Consulting. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "RootViewController.h"
#import "I_will_test_my_appsAppDelegate.h"
#import <CoreData/CoreData.h>
#import "CoreDataStackHelper.h"
#import "TestHelpers.h"

@interface RootViewControllerAppTests : SenTestCase <NSFetchedResultsControllerDelegate>
{
	I_will_test_my_appsAppDelegate*		appDelegate;
	RootViewController*					rootController;
	CoreDataStackHelper*				coreDataStackHelper;
	TestHelpers*					    testsHelper;
}

@end
