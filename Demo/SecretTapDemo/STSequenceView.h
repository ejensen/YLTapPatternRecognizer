//
//  STSequenceView.h
//  SecretTapDemo
//
//  Created by Eric Jensen on 7/7/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STSequenceView : UIView

@property (nonatomic, copy) UIColor *indicatorColor;
@property (nonatomic) NSUInteger total;
@property (nonatomic) NSUInteger completed;

@end

NS_ASSUME_NONNULL_END
