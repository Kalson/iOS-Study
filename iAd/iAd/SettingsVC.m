//
//  SettingsVC.m
//  iAd
//
//  Created by KaL on 11/10/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "SettingsVC.h"
#import "ViewController.h"
#import "StoreKitHelper.h"


@interface SettingsVC () <StoreKitHelperProtocol>

@end 

@implementation SettingsVC
{
    StoreKitHelper *skHelper;
    ViewController *ViewC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ViewC = [[ViewController alloc] init];
    skHelper = [[StoreKitHelper alloc]init];
    
    skHelper.delegate = self;
    [skHelper retriveProductIDs];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *goBackButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    goBackButton.backgroundColor = [UIColor grayColor];
    [goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [goBackButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBackButton];
    
    self.removeAdsButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    self.removeAdsButton.backgroundColor = [UIColor greenColor];
    [self.removeAdsButton addTarget:self action:@selector(removeAds) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.removeAdsButton];
    
    self.restorePurchaseButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 350, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    self.restorePurchaseButton .backgroundColor = [UIColor blueColor];
    [self.restorePurchaseButton  setTitle:@"Restore Purchase" forState:UIControlStateNormal];
    [self.restorePurchaseButton  addTarget:self action:@selector(restorePurchase) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.restorePurchaseButton ];
        
}

- (void)viewWillAppear:(BOOL)animated
{
    ViewC.removeAdsString = [skHelper.persistentData objectForKey:@"removeads"];

    NSLog(@"%@",ViewC.removeAdsString);

    // if not purchase
    if (![ViewC.removeAdsString isEqualToString:@"bought"]) {
        [self.removeAdsButton setTitle:@"Remove Ads" forState:UIControlStateNormal];
    } else {
        self.removeAdsButton.enabled = NO;
        self.restorePurchaseButton.enabled = NO;
        [self.removeAdsButton setTitle:@"Ads Removed" forState:UIControlStateNormal];
    }
}

- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)removeAds
{
//    SKPayment *payment = [SKPayment paymentWithProduct:self.removeAdsProduct];
//    [[SKPaymentQueue defaultQueue]addPayment:payment];
    
    // intiate the payment process:
    // create a payment, assign the product, and send off the payment
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:self.removeAdsProduct];
    payment.quantity = 1;
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)restorePurchase
{
    // restore previously completed transactions for IAP
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

// when the restore is completed
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
//    [ViewC unlockPurchase];
}

#pragma mark StoreKit Helper Protocol Methods
- (void)productsRetrieved:(NSArray *)products
{
    if (products.count > 0) {
        self.removeAdsProduct = products[0];
        
    }
}


@end
