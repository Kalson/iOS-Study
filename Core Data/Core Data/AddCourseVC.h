//
//  AddCourseVC.h
//  Core Data
//
//  Created by KaL on 9/9/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

// because of the way model view controllers should be done in general, were going to create this newCourse view controller by having its own delegate protocol

// just declaring it, so it can be used with a @property (apart from the UI @property and the course @property) because we need something thats going to hold a reference to whoever is going to be the delegate
@protocol AddCourseViewControllerDelegate;

@interface AddCourseVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;

// just an id of something that volunteers to be my delagate
@property (weak, nonatomic) id <AddCourseViewControllerDelegate> delegate;

// because we are gonna be passing in a course object
@property (nonatomic, strong) Course *currentCourse;

// now we need to actually define what methods that delegate needs to provide
// we want this modal view controller to do two things: hey, somebody click my save my button or my cancel button -> and its going to pass those behaviors to whoever is volunteering to be the delegate

- (IBAction)cancelButton:(id)sender;
- (IBAction)SaveButton:(id)sender;

@end

@protocol AddCourseViewControllerDelegate

- (void)addCourseViewControllerDidSave;
- (void)addCourseViewControllerDidCancel:(Course *)courseToDelete;
// but seeing how were creating a new course object(the course @property) and passing it in, if somebody wants to save we can just save, but if they want to cancel we have to make sure that object is removed

// protocols - lets you pass around behaviors (methods) in b/w classes, in this case in b/w this modal view controller and the table view controller that going to open it
@end
