//
//  ViewController.m
//  iAd
//
//  Created by KaL on 11/9/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "ViewController.h"
#import "SettingsVC.h"
#import "StoreKitHelper.h"

@interface ViewController () <ADBannerViewDelegate>

@end

@implementation ViewController
{
    UILabel *adsRemoveLabel;
    
    SettingsVC *settingsViewC;
    StoreKitHelper *skHelper;
    
//    NSString
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
    
    settingsViewC = [[SettingsVC alloc] init];
    skHelper = [[StoreKitHelper alloc]init];
    
    [settingsViewC.removeAdsButton setTitle:@"Ads Removed" forState:UIControlStateDisabled];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    // check flag to see if we should show Ads
   self.removeAdsString = [skHelper.persistentData objectForKey:@"removeads"];
    
    NSLog(@"%@",self.removeAdsString);
    
    // if not purchased
    if (![self.removeAdsString isEqualToString:@"bought"]) {
        self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 320, 50)];
        self.bannerView.delegate = self;
        self.bannerView.alpha = 0;
        self.bannerIsVisible = YES;
        [self.view addSubview:self.bannerView];
    } else {
        self.bannerView.hidden = YES;
        adsRemoveLabel.text = @"Ads have been removed";
    }
}

- (void)settings
{
    [self presentViewController:settingsViewC animated:YES completion:nil];
}

//- (void)unlockPurchase
//{
//    settingsViewC.removeAdsButton.enabled = NO;
//    settingsViewC.removeAdsButtonText = @"Ads Removed";
//}

#pragma mark - iAd Delegate Methods

// when there is connection
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    NSLog(@"ad shown");
    
//    if (!self.bannerIsVisible) {
    
//        // If banner isn't part of view hierarchy, add it
//        if (bannerView.superview == nil)
//        {
//            [self.view addSubview:bannerView];
//        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        banner.alpha = 1; // if there is a connection or the banner is not visible, we want to bring the AD back into the view
        [UIView commitAnimations];

        self.bannerIsVisible = YES;
//    }
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");

    if (self.bannerIsVisible) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        banner.alpha = 0; // if there is no a connection, fade out the banner
        [UIView commitAnimations];
        
        self.bannerIsVisible = NO;
    }
}


@end
