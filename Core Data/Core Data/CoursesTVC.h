//
//  CoursesTVC.h
//  Core Data
//
//  Created by KaL on 9/7/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCourseVC.h"

@interface CoursesTVC : UITableViewController <AddCourseViewControllerDelegate>
// next we (CoursesTVC) are going to volunteer, saying that we are able to be delegate for that course

// the whole idea is when we run this application, when we pressed the add course button -> we are going to create an object, pass it into the modal view controller and tell the modal view controller hey i'm ur delegate, so that when somebody clicks the save or cancel button we're passing those notification back to CoursesTVC (we either cancel and dismiss and get rid of that object or we save it to the persistent store)

@property (nonatomic,strong) NSManagedObjectContext *manageObjectContext;

// to tie Core Data fetch request to UItableViews in iOS
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
// to connect an array to the UITableViewController

// when u execute a fetch request, what u get back is an array of manageObjects

@end
