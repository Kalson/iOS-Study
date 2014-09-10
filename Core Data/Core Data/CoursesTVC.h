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

@property (nonatomic,strong) NSManagedObjectContext *manageObjectContext;

// to tie Core Data fetch request to UItableViews in iOS
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
// to connect an array to the UITableViewController

// when u execute a fetch request, what u get back is an array of manageObjects

@end
