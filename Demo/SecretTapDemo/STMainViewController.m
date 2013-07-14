//
//  STViewController.m
//  SecretTapDemo
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import "STMainViewController.h"
#import "YLTapPatternRecognizer.h"
#import <AudioToolbox/AudioToolbox.h>

@interface STMainViewController () {
    SystemSoundID _unlockChime;
}
@end

@implementation STMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareChime];
    
    YLTapPatternRecognizer *tapPatterRecognizer = [[YLTapPatternRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(didSecretTap:)];
    tapPatterRecognizer.pattern = [YLTapPatterns shaveAndAHaircut];
    self.sequenceView.total = tapPatterRecognizer.pattern.count;
    [self.view addGestureRecognizer:tapPatterRecognizer];
}

- (void)dealloc {
    if (_unlockChime) {
        AudioServicesDisposeSystemSoundID(_unlockChime);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.sequenceView.completed++;
}

- (void)didSecretTap:(YLTapPatternRecognizer *)gestureRecognizer {
    NSLog(@"Secret Unlocked!");
    
    [self performSelectorInBackground:@selector(playChime) withObject:nil];
    [self performSegueWithIdentifier:@"SecretUnlockedSegue" sender:self];
    self.sequenceView.completed = 0;
}

- (void)prepareChime {
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"SecretUnlock" withExtension:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &_unlockChime);
}

- (void)playChime {
    if (_unlockChime) {
        AudioServicesPlaySystemSound(_unlockChime);
    }
}

@end
