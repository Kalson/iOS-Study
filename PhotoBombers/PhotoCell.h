//
//  PhotoCell.h
//  PhotoBombers
//
//  Created by KaL on 8/3/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell

@property (nonatomic) UIImageView *imageView;

@property (nonatomic) NSDictionary *photo;
// here we'll pass in the photo dictionary from our photos array in our view controller.

@end
