//
//  SettingsVC.h
//  iAd
//
//  Created by KaL on 11/10/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface SettingsVC : UIViewController <SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) NSString *productID;

- (void)getProductID:(UIViewController *)viewController;

@end
