//
//  ViewController.m
//  Play Sound
//
//  Created by KaL on 10/21/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *soundButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 200, 100, 40)];
    soundButton.layer.cornerRadius = 5;
    soundButton.layer.borderWidth = 1;
    soundButton.layer.borderColor = [[UIColor blueColor]CGColor];
    [soundButton setTitle:@"Play Sound" forState:UIControlStateNormal];
    [soundButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [soundButton addTarget:self action:@selector(playSound) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soundButton];
}

- (void)playSound
{
    NSLog(@"bam");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
