//
//  CoursesTVC.h
//  Core Data
//
//  Created by KaL on 9/7/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoursesTVC : UITableViewController

@property (nonatomic,strong) NSManagedObjectContext *manageObjectContext;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
// to tie Core Data fetch request to UItableViews in iOS

// when u execute a fetch request, what u get back is an array of manageObjects

@end
