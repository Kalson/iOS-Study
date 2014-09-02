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
    UITextField *textName;
    UITextView *textInfo;
    
    UIImageView *imagePic;
    UITextView *movieInfo;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        
        //generic fix
//        self.automaticallyAdjustsScrollViewInsets = NO;
        // textView doesn't let me show the text when I conform it, why?
        
        textName = [[UITextField alloc]initWithFrame:CGRectMake(10, 90, SCREEN_WIDTH - 20, 40)];
        textName.backgroundColor = [UIColor redColor];
        [self.view addSubview:textName];
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
        textName.leftView = paddingView;
        textName.leftViewMode = UITextFieldViewModeAlways;
        
        textInfo = [[UITextView alloc]initWithFrame:CGRectMake(10, 140, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 150)];
        textInfo.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:textInfo];
        
        movieInfo = [[UITextView alloc]initWithFrame:CGRectMake(10, 120,  SCREEN_WIDTH - 20, 70)];
        movieInfo.backgroundColor = [UIColor greenColor];
        movieInfo.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:movieInfo];
        
        imagePic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 360)];
        [self.view addSubview:imagePic];
    
   
        // why does the textfield start at the middle when set to self.view.frame
        
        
//        TableVC *tableVC = [TableVC new];
//        [self.detailInfo addObject:@{@"Name":textView.text}];
//           self.detailInfo = tableVC.items[0];
//        NSLog(@"%@",self.detailInfo);
    }
    return self;
}
- (void)setDetailName:(NSString *)detailName
{
    _detailName = detailName;
    
    textName.text = detailName;
    
}

- (void)setDetailInfo:(NSString *)detailInfo
{
    _detailInfo = detailInfo;
    
    textInfo.text = detailInfo;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    imagePic.image = image;
}

- (void)setDetailMovieInfo:(NSString *)detailMovieInfo
{
    _detailMovieInfo = detailMovieInfo;
    
    movieInfo.text = detailMovieInfo;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.detailDict
}

@end
