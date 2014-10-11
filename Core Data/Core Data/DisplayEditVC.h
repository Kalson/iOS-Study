//
//  DisplayEditVC.h
//  Core Data
//
//  Created by KaL on 10/11/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface DisplayEditVC : UIViewController

// passing in a reference to a current Course object
@property (nonatomic, strong) Course *currentCourse;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;


@end
