//
//  STViewController.m
//  SecretTapDemo
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import "STMainViewController.h"
#import "YLTapPatternRecognizer.h"
#import <AVFoundation/AVFoundation.h>

@interface STMainViewController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation STMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelectorInBackground:@selector(prepareChime) withObject:nil];
    [self.view addGestureRecognizer:[[YLTapPatternRecognizer alloc] initWithTarget:self action:@selector(didSecretTap:)]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tapFlashView.alpha = 0.9;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tapFlashView.alpha = 1;
}

- (void)didSecretTap:(YLTapPatternRecognizer *)gestureRecognizer {
    NSLog(@"Secret Unlocked!");
    
    self.tapFlashView.alpha = 1;
    [self performSelectorInBackground:@selector(playChime) withObject:nil];
    [self performSegueWithIdentifier:@"SecretUnlockedSegue" sender:self];
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