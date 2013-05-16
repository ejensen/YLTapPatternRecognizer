//
//  STViewController.m
//  SecretTapGestureRecognizer
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import "STViewController.h"
#import "STSecretTapGestureRecognizer.h"

@implementation STViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[STSecretTapGestureRecognizer alloc] initWithTarget:self action:@selector(didSecretTap:)]];
}

- (void)didSecretTap:(STSecretTapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Pattern Matched!");
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.backgroundColor = [UIColor greenColor];
    });
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
