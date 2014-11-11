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
{
    UIButton *removeAdsButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *goBackButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    goBackButton.backgroundColor = [UIColor grayColor];
    [goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
    [goBackButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBackButton];
    
    removeAdsButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width - 40, 40)];
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
    
    // create a request if payments can be made
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
    // process payment
    SKPayment *payment = [SKPayment paymentWithProduct:self.product];
    [[SKPaymentQueue defaultQueue]addPayment:payment];
}

- (void)restorePurchase
{
    // restore previously completed transactions for IAP
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark SkPayment Delegates methods
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    // when the App Store responds to the product request, check to see if there any products
    if (products.count !=0) {
        self.product = products[0];

    }
    
    
    for (SKProduct *product in products) {
        NSLog(@"Product could not be found: %@",product);
    }
}


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{

    // if the purchase or transaction is successful
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:[self unlockPurchase];
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                break;
                
            // or if transcations fails
            case SKPaymentTransactionStateFailed:NSLog(@"Transaction failed");
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}

- (void)unlockPurchase
{
//    removeAdsButton.enabled = NO;
    [removeAdsButton setTitle:@"Ads Removed" forState:UIControlStateDisabled];
    [self.ViewC purchased];
}

@end
