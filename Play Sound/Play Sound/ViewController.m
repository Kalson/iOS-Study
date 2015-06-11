//
//  ViewController.m
//  Play Sound
//
//  Created by KaL on 10/21/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController
{
      // plays the sounds
      AVAudioPlayer *audioPlayer;
    
    // use the AVAudioplayer, then System Sound Services that uses the AudioToolbox framework b/c its not limited like System Sound Services are
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // assign url to soundfile
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"NuclearAlarm" ofType:@"mp3"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];

    // alloc and intialize the audioplayer with NSURL to sound
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
    
    
    UIButton *soundButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 200, 100, 40)];
    soundButton.layer.cornerRadius = 5;
    soundButton.layer.borderWidth = 1;
    soundButton.layer.borderColor = [[UIColor blueColor]CGColor];
    [soundButton setTitle:@"Play Sound" forState:UIControlStateNormal];
    [soundButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [soundButton addTarget:self action:@selector(playSound) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soundButton];
}

- (void)playSound
{
    [audioPlayer play];
    NSLog(@"bam");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
