//
//  PhotoController.m
//  PhotoBombers
//
//  Created by KaL on 8/28/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "PhotoController.h"

#import <SAMCache/SAMCache.h>


@implementation PhotoController

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size compeletion:(void(^)(UIImage *image))completion
{
    // We want to cache these photos on disk - Once a photo has been downloaded, we can prevent it from downloading again by accessing it locally from the disk.
    
    // we set up our cache key with the ID of our photo and the word thumbnail.
    NSString *key = [NSString stringWithFormat:@"%@-%@", photo[@"id"], size];
    
    // You can't call blocks that are nil unlike most things in Objective-C. If you tried to, it would crash. So, we should check in the beginning of our method.
    if (photo == nil || size == nil || completion == nil) {
        return;
    }
    
    // we try to get the photo out of the shared cache using our key.
    UIImage *image = [[SAMCache sharedCache] imageForKey:key];
    if (image) {
        
        // And instead of calling self.imageView.image, cuz this class doesn't have an image view, we'll call its completion block.
        completion(image);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:photo[@"images"][size][@"url"]];
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
            completion(image);
            
            //  ^ If we did this in the background, it wouldn't work that well, because imageView isn't intended to be called from any queues other than the main queue.
        });
    }];
    [task resume];
}

@end
