//
//  ViewController.h
//  iAd
//
//  Created by KaL on 11/9/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface ViewController : UIViewController

@property (nonatomic) BOOL bannerIsVisible;
@property (nonatomic) ADBannerView *bannerView;

@property (nonatomic) NSString *removeAdsString;

@end

