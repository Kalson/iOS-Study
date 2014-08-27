//
//  PhotoCell.m
//  PhotoBombers
//
//  Created by KaL on 8/3/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "PhotoCell.h"

#import <SAMCache/SAMCache.h>

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:self.imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(like)];
        tap.numberOfTapsRequired = 2;
        
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)layoutSubview
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    
}

- (void)like
{
    NSLog(@"link: %@",self.photo[@"link"]);
    
    // Now, a simple request to use this URL to like the photo.
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", self.photo[@"id"], accessToken];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Since we need to change our request from the default, we need to make a mutable request.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    //  We can notice back in the documentation it says this is a post. That means we're gonna use the post HTTP method. Before we used the Get method, which is the default.
    request.HTTPMethod = @"POST";
    // normally u use post, when you're creating things and in this case we're creating a like
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response: %@",response);
        NSLog(@"data: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLikeCompletion];

        });
    }];
    [task resume];
  
}

- (void)showLikeCompletion
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Liked" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    
    // dismisses the alertView after 1 seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

// setPhoto gets called anytime someone writes "cell.photos ="
- (void)setPhoto:(NSDictionary *)photo
{
    // _photo is our instance variable
    _photo = photo;
    
    NSURL *url = [NSURL URLWithString:_photo[@"images"][@"standard_resolution"][@"url"]];
    
    [self downloadPhotoWithURL:url];
}

- (void)downloadPhotoWithURL:(NSURL *)url
{
    
    // We want to cache these photos on disk - Once a photo has been downloaded, we can prevent it from downloading again by accessing it locally from the disk.
    
    // we set up our cache key with the ID of our photo and the word thumbnail.
    NSString *key = [NSString stringWithFormat:@"%@-thumabnail", self.photo[@"id"]];
    
    // we try to get the photo out of the shared cache using our key.
    UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
    if (photo) {
        self.imageView.image = photo;
        return;
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        //  for the completion handler, we need to get our image from the location, and set it on the image view.
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        [[SAMCache sharedCache] setImage:image forKey:key];
        // Now, remember we learned we have to go back to the main lane in our traffic analogy. So we'll say dispatch, async dispatch get main queue.
        dispatch_async(dispatch_get_main_queue(), ^{        // This dispatches asynchronously, so we don't block this background queue.
            // We're gonna dispatch asynchronously to the main queue. Because that's where we have to update our UI.
            self.imageView.image = image;
            
            //  ^ If we did this in the background, it wouldn't work that well, because imageView isn't intended to be called from any queues other than the main queue.
        });
    }];
    [task resume];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
