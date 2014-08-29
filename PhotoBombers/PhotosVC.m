//
//  PhotosViewController.m
//  PhotoBombers
//
//  Created by KaL on 7/27/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "PhotosVC.h"
#import "PhotoCell.h"
#import "DetailViewController.h"

#import <SimpleAuth/SimpleAuth.h>

@interface PhotosVC ()

@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *photos;

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
            [SimpleAuth authorize:@"instagram" options:@{@"scope": @[@"likes"]} completion:^(NSDictionary *responseObject, NSError *error)
             {
                 
            // This will let us connect to Instagram later and make authenticated requests.
            self.accessToken = responseObject[@"credentials"][@"token"];
                 
            [userDefault setObject:self.accessToken forKey:@"accessToken"];
            
            // synchronize saves NSUserDefaults to the disk
            [userDefault synchronize];
                 
                 // This will cause our view to reload after we sign in
                 [self refresh];
                 
             }];
           
            
        } else {
            [self refresh];

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

- (void)refresh
{
    // if we do, we don't need to ask the user to sign in.
    NSLog(@"Signed In!");
    
    //  Now that we have the access token, let's make an authenticated request to Instagram. And for now, we'll just log some urls of photos.
    NSURLSession *session = [NSURLSession sharedSession];
    
    // url for our request
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/photobomb/media/recent?access_token=%@",self.accessToken];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // to download info from the internet (it writes the server's response data into a temporary file that provides the app with progress updates)
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {
      /*
       NSLog(@"Response: %@",response);
       // to get the content of the url
       NSString *text = [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
       
       NSLog(@"text: %@",text); */
      
      // after getting the json response from this ^ and pasting it on prettyjson.com
      NSData *data = [NSData dataWithContentsOfURL:location];
        
        // the response from Instagram
      NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        // converts the json into foundation objects
      
      //  make an array of the photos to get them
      self.photos = [responseDictionary valueForKeyPath:@"data"];
        
        // @"data.images.standard_resolution.url" for just getting URLs
        
      //  We need to tell the collection view to reload its data, since collection view doesn't know when we change our data source.
        // We also need to do this back on the main queue. Because the collection view is intended to be called from the main queue.
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];
    
    [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    
    cell.photo = self.photos[indexPath.row];
    // This gets the photo out of the photo's array, for a corresponding row and sets it on our cell.
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    detailVC.photo = self.photos[indexPath.row];
}



@end







