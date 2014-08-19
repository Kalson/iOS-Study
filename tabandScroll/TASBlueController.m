//
//  TASBlueController.m
//  tabandScroll
//
//  Created by KaL on 8/17/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "TASBlueController.h"

@interface TASBlueController ()

@end

@implementation TASBlueController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"blue";
        self.view.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(320, 560);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.view addSubview:scrollView];
    
    NSLog(@"%@",scrollView);
    
    UILabel *stuff = [[UILabel alloc]initWithFrame:CGRectMake(20, 520, 100, 40)];
    stuff.text = @"Stuff";
    [scrollView addSubview:stuff];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(22, 20, 280, 300)];
    textView.text = @"The UITextView class implements the behavior for a scrollable, multiline text region. The class supports the display of text using custom style information and also supports text editing. You typically use a text view to display multiple lines of text, such as when displaying the body of a large text document.";
//    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:20];
    [scrollView addSubview:textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
