//
//  ViewController.m
//  iAd
//
//  Created by KaL on 11/9/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "ViewController.h"
#import <iAd/iAd.h>

@interface ViewController () <ADBannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ADBannerView *bannerView = ADAdTypeMediumRectangle
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma iAd Delegate Methods

// when there is connection
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    banner.alpha = 1; // if there is a connection, we want to bring the AD back into the view
    [UIView commitAnimations];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    banner.alpha = 0; // if there is no a connection, fade out the banner
    [UIView commitAnimations];
}

@end
