//
//  SettingsVC.m
//  iAd
//
//  Created by KaL on 11/10/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "SettingsVC.h"
#import "ViewController.h"


@interface SettingsVC ()

@property (strong,nonatomic) ViewController *ViewC;

@end 

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *goBackButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    goBackButton.backgroundColor = [UIColor grayColor];
    [goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [goBackButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBackButton];
    
    UIButton *removeAdsButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    removeAdsButton.backgroundColor = [UIColor greenColor];
    [removeAdsButton setTitle:@"No Ads" forState:UIControlStateNormal];
    [removeAdsButton addTarget:self action:@selector(removeAds) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeAdsButton];
    
    UIButton *restorePurchaseButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 350, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    restorePurchaseButton.backgroundColor = [UIColor blueColor];
    [restorePurchaseButton setTitle:@"Restore Purchase" forState:UIControlStateNormal];
    [restorePurchaseButton addTarget:self action:@selector(restorePurchase) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restorePurchaseButton];
    
    
}

- (void)getProductID:(ViewController *)viewController{
    
    _ViewC = viewController;
    
    if ([SKPaymentQueue canMakePayments]) {
        SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:self.productID]];
        request.delegate = self;
        
        [request start];
    }
    
}


- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)removeAds
{
    
}

- (void)restorePurchase
{
    
}

#pragma mark SkPayment Delegates methods
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    
}

//- paymentqueu

@end
