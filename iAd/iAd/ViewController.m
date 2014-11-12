//
//  ViewController.m
//  iAd
//
//  Created by KaL on 11/9/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "ViewController.h"
#import "SettingsVC.h"
#import <iAd/iAd.h>

@interface ViewController () <ADBannerViewDelegate>

@end

@implementation ViewController
{
    ADBannerView *bannerView;
    BOOL bannerIsVisible;
    
    UILabel *adsRemoveLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *settingsButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    settingsButton.backgroundColor = [UIColor redColor];
    [settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingsButton];
    
    adsRemoveLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 250, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    adsRemoveLabel.textAlignment = NSTextAlignmentCenter;
    adsRemoveLabel.text = @"Ads have not been removed";
    [self.view addSubview:adsRemoveLabel];
    
    
    
}

- (void)settings
{
    SettingsVC *SettingsViewC = [[SettingsVC alloc]init];
    
    // telling the product id to load iAP purchase item
    SettingsViewC.productID = @"KaL.iAd.IAP";
    [SettingsViewC getProductID:self];
    [self presentViewController:SettingsViewC animated:YES completion:nil];
}

- (void)purchased
{
    adsRemoveLabel.text = @"Ads have been removed";
}

- (void)viewWillAppear:(BOOL)animated
{
    bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 320, 50)];
    bannerView.delegate = self;
    bannerView.alpha = 0;
    
}

#pragma iAd Delegate Methods

// when there is connection
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    NSLog(@"ad shown");
    
    if (!bannerIsVisible) {
        
//        // If banner isn't part of view hierarchy, add it
//        if (bannerView.superview == nil)
//        {
//            [self.view addSubview:bannerView];
//        }
        
        [self.view addSubview:bannerView];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        banner.alpha = 1; // if there is a connection or the banner is not visible, we want to bring the AD back into the view
        [UIView commitAnimations];

        bannerIsVisible = YES;
    }
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");

    if (bannerIsVisible) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        banner.alpha = 0; // if there is no a connection, fade out the banner
        [UIView commitAnimations];
        
        bannerIsVisible = NO;
    }
    
    
}

@end
