//
//  StoreKitHelper.h
//  iAd
//
//  Created by KaL on 11/11/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "SettingsVC.h"
#import "ViewController.h"


// the way classes talk to each other is too implement a protocol
@protocol StoreKitHelperProtocol <NSObject>

- (void)productsRetrieved:(NSArray *)products;

@end

@class SettingsVC;

@interface StoreKitHelper : NSObject <SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, weak) id <StoreKitHelperProtocol> delegate;

@property (nonatomic, strong) SettingsVC *settingsViewC;
@property (nonatomic, strong) ViewController *viewC;

@property (nonatomic, strong) NSUserDefaults *persistentData;

- (void)retriveProductIDs;

@end
