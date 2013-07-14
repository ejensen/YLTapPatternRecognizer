//
//  STSequenceView.h
//  SecretTapDemo
//
//  Created by Eric Jensen on 7/7/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STSequenceView : UIView

@property (nonatomic, copy) UIColor *indicatorColor;
@property (nonatomic, assign) NSUInteger total;
@property (nonatomic, assign) NSUInteger completed;

@end
