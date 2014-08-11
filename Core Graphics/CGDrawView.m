//
//  CGDrawView.m
//  Core Graphics
//
//  Created by KaL on 8/5/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "CGDrawView.h"

@implementation CGDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddLineToPoint(context, 0, 0);
    
}

@end
