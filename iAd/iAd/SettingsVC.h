//
//  SettingsVC.h
//  iAd
//
//  Created by KaL on 11/10/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>


@interface SettingsVC : UIViewController 

@property (strong, nonatomic) SKProduct *removeAdsProduct;
@property (strong, nonatomic) NSString *productID;

@property (strong, nonatomic) UIButton *removeAdsButton;
@property (strong, nonatomic) UIButton *restorePurchaseButton;

@end
