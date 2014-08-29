//
//  DetailVC.m
//  TableView App
//
//  Created by KaL on 8/28/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "DetailVC.h"
#import "TableVC.h"

@interface DetailVC ()

@end

@implementation DetailVC
{
    UITextField *textView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        
        textView = [[UITextField alloc]initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH - 20, 40)];
        textView.backgroundColor = [UIColor redColor];
        [self.view addSubview:textView];
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
        textView.leftView = paddingView;
        textView.leftViewMode = UITextFieldViewModeAlways;

        
        
        // textView doesn't let me show the text when I conform it, why?
        // why does the textfield start at the middle when set to self.view.frame
        
        
//        TableVC *tableVC = [TableVC new];
//        [self.detailInfo addObject:@{@"Name":textView.text}];
//           self.detailInfo = tableVC.items[0];
//        NSLog(@"%@",self.detailInfo);
    }
    return self;
}
- (void)setDetailInfo:(NSString *)detailInfo
{
    _detailInfo = detailInfo;
    
    textView.text = detailInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.detailDict
}

@end
