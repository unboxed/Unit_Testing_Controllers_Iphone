//
//  Note.h
//  I_will_test_my_apps
//
//  Created by Borja Arias Drake on 24/08/2010.
//  Copyright 2010 Unboxed Consulting. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Note :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * text;

@end



