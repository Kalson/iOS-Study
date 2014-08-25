//
//  NAViewController.m
//  NotesPad
//
//  Created by KaL on 8/19/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "NAItemInfoVC.h"

@interface NAItemInfoVC ()<UITextViewDelegate>

@end

@implementation NAItemInfoVC
{
    UITextView *textView;
    UIBarButtonItem *done;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                
        done = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton)];
        self.navigationItem.rightBarButtonItem = done;
        
//        itemInfo = ([self loadItemData]) ? [self loadItemData]:[self saveItemData];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    textView = [[UITextView alloc]initWithFrame:self.view.frame];
    [textView becomeFirstResponder];
    textView.font = [UIFont systemFontOfSize:20];
    textView.delegate = self;
    [self.view addSubview:textView];

}

//- (void)viewWillAppear:(BOOL)animated
//{
//    
//    self.navigationItem.rightBarButtonItem = done;
//}

- (void)doneButton
{
    [textView resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
    
    [self.itemInfo addObject:[@{
                                 @"text" :textView.text
                                }mutableCopy]];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
     self.navigationItem.rightBarButtonItem = done;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
