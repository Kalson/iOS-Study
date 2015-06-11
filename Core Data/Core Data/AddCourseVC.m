//
//  AddCourseVC.m
//  Core Data
//
//  Created by KaL on 9/9/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import "AddCourseVC.h"

@interface AddCourseVC ()

@end

@implementation AddCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleField.text = self.currentCourse.title;
    self.authorField.text = self.currentCourse.author;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    self.dateField.text = [dateFormat stringFromDate:self.currentCourse.releaseDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButton:(id)sender {
    // dismiss and remove the object
    
    // announce to the delegate that its ready to take this
    [self.delegate addCourseViewControllerDidCancel:[self currentCourse]];
}

- (IBAction)SaveButton:(id)sender {
    // dismiss and save the context
    // setting the manage objects in the data model with the textfields
    [self.currentCourse setTitle:self.titleField.text];
    [self.currentCourse setAuthor:self.authorField.text];
    
    // so that we can convert the textfield of the date back into a date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [self.currentCourse setReleaseDate:[dateFormat dateFromString:self.dateField.text]];

    // announce to the delegate that its ready to take this
    [self.delegate addCourseViewControllerDidSave];

}
@end
