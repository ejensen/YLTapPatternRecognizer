//
//  STViewController.m
//  SecretTapGestureRecognizer
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import "STViewController.h"
#import "SecretTapGestureRecognizer.h"

#import <AVFoundation/AVFoundation.h>

@interface STViewController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation STViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelectorInBackground:@selector(prepareChime) withObject:nil];
    [self.view addGestureRecognizer:[[SecretTapGestureRecognizer alloc] initWithTarget:self action:@selector(didSecretTap:)]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.successImageView.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didSecretTap:(SecretTapGestureRecognizer *)gestureRecognizer {
    NSLog(@"Secret Unlocked!");
    
    [self performSelectorInBackground:@selector(playChime) withObject:nil];
    
    self.successImageView.alpha = 0;
    self.successImageView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.successImageView.alpha = 1;
    }];
}

- (void)prepareChime {
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"SecretUnlock" withExtension:@"mp3"];
    NSError *error;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    if (!error && soundURL) {
        self.audioPlayer = audioPlayer;
        audioPlayer.volume = 0.5f;
        [audioPlayer prepareToPlay];
    }
}

- (void)playChime {
    [self.audioPlayer play];
}

@end
