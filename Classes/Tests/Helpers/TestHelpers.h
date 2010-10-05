//
//  TestHelpers.h
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 04/10/2010.
//  Copyright 2010 Unboxed Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TestHelpers : NSObject <NSFetchedResultsControllerDelegate>
{
}

- (NSFetchedResultsController*) mockFetchResultController: (NSManagedObjectContext*) context;
- (void)insertNewNoteInContext: (NSManagedObjectContext*) cntx andDate: (NSDate*) date;
- (void) deleteNotes: (NSManagedObjectContext*) context fetchController:(NSFetchedResultsController*) frc;

@end


