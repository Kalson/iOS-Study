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
