//
//  UDBouncyBehavior.m
//  UIKitDynamics
//
//  Created by KaL on 8/17/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "UDBouncyBehavior.h"

@interface UDBouncyBehavior ()

@end

@implementation UDBouncyBehavior

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (instancetype)initWithItems:(NSArray *)items {
//    if (!(self = [super init])) return nil;
//    
//    UIGravityBehavior* gravityBehavior = [[UIGravityBehavior alloc] initWithItems:items];
//    [self.view addChildBehavior:gravityBehavior];
//    
//    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
//    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//    [self addChildBehavior:collisionBehavior];
//    
//    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:items];
//    elasticityBehavior.elasticity = 0.7f;
//    [self addChildBehavior:elasticityBehavior];
//    
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
