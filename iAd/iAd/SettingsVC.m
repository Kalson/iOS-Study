//
//  SettingsVC.m
//  iAd
//
//  Created by KaL on 11/10/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "SettingsVC.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *goBack = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    goBack.backgroundColor = [UIColor grayColor];
    [goBack setTitle:@"Go Back" forState:UIControlStateNormal];
    [goBack addTarget:self action:@selector(goBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBack];
    
    UIButton *removeAds = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    removeAds.backgroundColor = [UIColor greenColor];
    [removeAds setTitle:@"Remove Ads" forState:UIControlStateNormal];
    [removeAds addTarget:self action:@selector(removeAdsButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeAds];
    
    UIButton *restorePurchase = [[UIButton alloc]initWithFrame:CGRectMake(20, 350, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    restorePurchase.backgroundColor = [UIColor blueColor];
    [restorePurchase setTitle:@"Restore Purchase" forState:UIControlStateNormal];
    [restorePurchase addTarget:self action:@selector(restorePurchaseButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restorePurchase];
    

    
}

- (void)goBackButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)removeAdsButton
{
    
}

- (void)restorePurchaseButton
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
