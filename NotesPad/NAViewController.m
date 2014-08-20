//
//  NAViewController.m
//  NotesPad
//
//  Created by KaL on 8/19/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "NAViewController.h"

@interface NAViewController ()<UITextViewDelegate>

@end

@implementation NAViewController
{
    NSMutableDictionary *itemInfo;
    UITextView *textView;
    UIBarButtonItem *done;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        
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

- (void)doneButton
{
    [textView resignFirstResponder];
    done.title = @"";
    
    // ask jo for a better way to remove the button
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    done.title = @"Done";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveItemData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:itemInfo];
    [data writeToFile:[self itemFilePath] atomically:YES];
}

- (void)loadItemData
{
    [NSKeyedUnarchiver unarchiveObjectWithFile:[self itemFilePath]];
}

- (NSString *)itemFilePath
{
    NSArray *docoumentDictories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *path = docoumentDictories[0];
    
    return [path stringByAppendingString:@"items.data"];
    
    
}

@end
