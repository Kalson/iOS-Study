//
//  DetailVC.h
//  TableView App
//
//  Created by KaL on 8/28/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVC : UIViewController

@property (nonatomic) NSString *detailName;
@property (nonatomic) NSString *detailInfo;
@property (nonatomic) NSString *detailMovieInfo;
@property (nonatomic) UIImage *image;

@property (nonatomic)UITextView *movieInfo;

// the property depends on what ur passing through the value

// get better with debugging by using breakpoints

@end
