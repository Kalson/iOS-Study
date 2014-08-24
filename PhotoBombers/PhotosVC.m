//
//  PhotosViewController.m
//  PhotoBombers
//
//  Created by KaL on 7/27/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "PhotosVC.h"
#import "PhotoCell.h"

#import <SimpleAuth/SimpleAuth.h>

@interface PhotosVC ()

@property (nonatomic) NSString *accessToken;

@end

@implementation PhotosVC

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    
    return (self = [super initWithCollectionViewLayout:layout]);
}



- (void)viewDidLoad
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.title = @"Photo Bombers";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefault objectForKey:@"accessToken"];

    
   
        // So we'll need to see, when their app launches, if we had the access token saved...
        if (self.accessToken == nil) {
            
            // if we don't, we will need to ask them to sign in.
            [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error)
             {
                 
            // This will let us connect to Instagram later and make authenticated requests.
            NSString *accessToken = responseObject[@"credentials"][@"token"];
                 
            [userDefault setObject:accessToken forKey:@"accessToken"];
            
            // synchronize saves NSUserDefaults to the disk
            [userDefault synchronize];
                 
             }];
            
        } else {
            // if we do, we don't need to ask the user to sign in.
            NSLog(@"Signed In!");
            
          //  Now that we have the access token, let's make an authenticated request to Instagram. And for now, we'll just log some urls of photos.
            NSURLSession *session = [NSURLSession sharedSession];
            
            // url for our request
            NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/photobomb/media/recent?access_token=%@",self.accessToken];

            NSURL *url = [NSURL URLWithString:urlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                // to get the content of the url
                NSString *text = [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
                
                NSLog(@"text: %@",text);
            }];
            
            [task resume];

        }
    
    /*
     
     NSURLSession *session = [NSURLSession sharedSession];
     
     NSURL *url = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     
     // to download info from the internet
     NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
     
     // to get the content of the url
     NSString *text = [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
     
     NSLog(@"Response: %@",text);
     }];
     
     [task resume];
     */

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}




@end
