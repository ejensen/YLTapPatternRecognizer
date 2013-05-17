//
//  STViewController.m
//  SecretTapGestureRecognizer
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import "STViewController.h"
#import "SecretTapGestureRecognizer.h"

@implementation STViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[SecretTapGestureRecognizer alloc] initWithTarget:self action:@selector(didSecretTap:)]];
}

- (void)didSecretTap:(SecretTapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Secret Unlocked!");
    
    self.successImageView.alpha = 0;
    self.successImageView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.successImageView.alpha = 1;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.successImageView.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
