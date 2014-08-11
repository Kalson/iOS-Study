//
//  ADANewGroupViewController.m
//  Adding Groups
//
//  Created by KaL on 8/3/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "ADANewGroupViewController.h"
#import "ADATableViewController.h"

@interface ADANewGroupViewController ()<UITextFieldDelegate>

@end

@implementation ADANewGroupViewController
{
    UIButton *leftbutton;
    UIButton *rightbutton;
    UITextField *newGroupTextField;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(175, SCREEN_HEIGHT - 380 , 120, 120)];
    [rightbutton addTarget:self action:@selector(saveButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.layer.borderWidth = 1;
    [self.view addSubview:rightbutton];
    
    leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT - 380 , 120, 120)];
    [leftbutton addTarget:self action:@selector(cancelButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    leftbutton.layer.borderWidth = 1;
    [self.view addSubview:leftbutton];
    
    newGroupTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 450 , SCREEN_WIDTH - 20, 30)];
    newGroupTextField.layer.borderWidth = 1;
    newGroupTextField.delegate = self;
    [newGroupTextField becomeFirstResponder];
    [self.view addSubview:newGroupTextField];
    
    
}

- (void)saveButtonWasPressed
{
    NSLog(@"Save Button was pressed");
    
    [self.groups addObject:[@{
                              @"name": newGroupTextField.text,
                              @"items": [@[]mutableCopy]
                              } mutableCopy]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (void)cancelButtonWasPressed
{
    NSLog(@"Cancel Button was pressed");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




@end
