//
//  RootViewController.h
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 24/08/2010.
//  Copyright Unboxed Consulting 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{

@private
    NSFetchedResultsController*  fetchedResultsController_;
    NSManagedObjectContext*      managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext*      managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController*  fetchedResultsController;
- (void)insertNewObject;
@end
