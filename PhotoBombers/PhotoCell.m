//
//  PhotoCell.m
//  PhotoBombers
//
//  Created by KaL on 8/3/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoController.h"

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

// setPhoto gets called anytime someone writes "cell.photos ="
- (void)setPhoto:(NSDictionary *)photo
{
    // _photo is our instance variable
    _photo = photo;
    
    [PhotoController imageForPhoto:_photo size:@"thumbnail" compeletion:^(UIImage *image) {
        self.imageView.image = image;
    }];
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



@end
