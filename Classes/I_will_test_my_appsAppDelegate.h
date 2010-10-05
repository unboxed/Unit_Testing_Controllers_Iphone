//
//  I_will_test_my_appsAppDelegate.h
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 24/08/2010.
//  Copyright Unboxed Consulting 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataStackHelper.h"

@interface I_will_test_my_appsAppDelegate : NSObject <UIApplicationDelegate>
{
    
    UIWindow *window;
    UINavigationController *navigationController;

@private
    NSManagedObjectContext*        managedObjectContext_;
    NSManagedObjectModel*          managedObjectModel_;
    NSPersistentStoreCoordinator*  persistentStoreCoordinator_;
	CoreDataStackHelper*		   coreDataStackHelper;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) CoreDataStackHelper* coreDataStackHelper;

- (NSString *)applicationDocumentsDirectory;
- (NSManagedObjectContext *)managedObjectContext;

@end

