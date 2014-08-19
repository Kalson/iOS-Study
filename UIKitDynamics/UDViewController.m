//
//  UDViewController.m
//  UIKitDynamics
//
//  Created by KaL on 8/17/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "UDViewController.h"
#import "UDBouncyBehavior.h"

@interface UDViewController () <UIAlertViewDelegate>

@end

@implementation UDViewController
{
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
    UICollisionBehavior *collision;
    UIDynamicItemBehavior *itemBehavior;
    UIAttachmentBehavior *attachment;
//    UIDynamicItemBehavior *smallboxBehavior;
    
    UIAlertView *alert;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UDBouncyBehavior *bouncyBehavior = [[UDBouncyBehavior alloc]init];
//    [animator addBehavior:bouncyBehavior];
    
    // intialize the animator with the view
    
    
    animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    
    
//    gravity = [[UIGravityBehavior alloc]init];
//    [animator addBehavior:gravity];
//    
//    collision = [[UICollisionBehavior alloc]init];
//    collision.translatesReferenceBoundsIntoBoundary = YES;
//    [animator addBehavior:collision];
//    
//    itemBehavior = [[UIDynamicItemBehavior alloc]init];
//    itemBehavior.elasticity = 1;
//    [animator addBehavior:itemBehavior];
//
//    
//    UIView *box = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
//    box.backgroundColor = [UIColor redColor];
//    box.center = CGPointMake(SCREEN_WIDTH/2, 300);
//    [self.view addSubview:box];
//    
//    [gravity addItem:box];
//    [collision addItem:box];
//    
//    UIView *smallbox = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
//    smallbox.backgroundColor = [UIColor greenColor];
//    smallbox.center = CGPointMake(0, 100);
//    [self.view addSubview:smallbox];
//    
//    attachment = [[UIAttachmentBehavior alloc]initWithItem:box attachedToAnchor:smallbox.center];
//    attachment.damping = 0.1;
//    attachment.frequency = 1.0;
//    
//    [animator addBehavior:attachment];
//
//    
//
//    [itemBehavior addItem:box];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(40,SCREEN_HEIGHT - 50, 100, 40)];
    [button setTitle:@"Alert View" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(alertButton) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10;
    button.layer.borderWidth = 1;
    [self.view addSubview:button];
    
  
}


- (void)alertButton
{
   alert = [[UIAlertView alloc]initWithTitle:@"Title" message:@"message" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
    UIView* random = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:random];
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:random snapToPoint:self.view.center];
    snapBehavior.damping = 0.7;
    [animator addBehavior:snapBehavior];
    
}

@end
