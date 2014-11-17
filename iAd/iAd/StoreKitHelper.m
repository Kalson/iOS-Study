//
//  StoreKitHelper.m
//  iAd
//
//  Created by KaL on 11/11/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "StoreKitHelper.h"


@implementation StoreKitHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        // create persistence data
        self.persistentData = [NSUserDefaults standardUserDefaults];

    }
    return self;
}

- (void)retriveProductIDs
{
    // Parse the plist
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"product_ids"
                                         withExtension:@"plist"];
    NSArray *productIdentifiers = [NSArray arrayWithContentsOfURL:url];
    
    // pass the product Identifiers to the validate method
    [self validateProductIdentifiers:productIdentifiers];

}

// Custom method
- (void)validateProductIdentifiers:(NSArray *)productIdentifiers
{
    // create product request
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                          initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
    productsRequest.delegate = self;
    [productsRequest start];
}

#pragma mark SkPayment Delegates methods

// SKProductsRequestDelegate protocol method
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{

    // if products recieved, notify delegate
    if (self.delegate) {
        [self.delegate productsRetrieved:response.products];
    }
}

#pragma mark - Trasactions Observer Delegates Methods

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        
        // check each transaction state
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
                
            default:
                // For debugging
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                break;
        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    // Display a message to the user that purchase was successful
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Purchase Successful" message:@"Thank You, Your puchase was successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
    

    
    // set a flag in the user defaults to not show Ads
    [self.persistentData setObject:@"bought" forKey:@"removeads"];
    [self.persistentData synchronize];
 
    [[SKPaymentQueue defaultQueue]finishTransaction:transaction];

    
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    // Display a message to the user that purchase was not successful
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Cancel Purchase" message:@"Your puchase was canceled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
    
    [[SKPaymentQueue defaultQueue]finishTransaction:transaction];

    
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    // Display a message to the user that purchase was successful
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Restore Successful" message:@"Remove Ads have been restored." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    // set a flag in the user defaults to not show Ads
    [self.persistentData setObject:@"bought" forKey:@"removeads"];
    [self.persistentData synchronize];
    
    [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
    
}


@end




