//
//  STViewController.h
//  SecretTapDemo
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STSequenceView.h"

@interface STMainViewController : UIViewController<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *tapFlashView;
@property (weak, nonatomic) IBOutlet STSequenceView *sequenceView;

@end
