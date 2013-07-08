//
//  STSequenceView.m
//  SecretTapDemo
//
//  Created by Eric Jensen on 7/7/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import "STSequenceView.h"
#import <QuartzCore/QuartzCore.h>

@interface STSequenceView ()
@property (nonatomic, strong) NSMutableArray *indicatorViews;
@end

@implementation STSequenceView

@synthesize sequence = _sequence;
@synthesize indicatorColor = _indicatorColor;
@synthesize numberCompleted = _numberCompleted;

- (void)setSequence:(NSArray *)sequence {
    _sequence = [sequence copy];
    [self resetIndictors];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    if ([indicatorColor isEqual:_indicatorColor]) {
        _indicatorColor = indicatorColor;
        [self refreshIndicators];
    }
}

- (void)setNumberCompleted:(NSUInteger)numberCompleted {
    if (numberCompleted != _numberCompleted) {
        _numberCompleted = numberCompleted;
        [self refreshIndicators];
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorColor = [UIColor lightGrayColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _indicatorColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)resetIndictors {
    self.numberCompleted = 0;
    
    for (UIView *indicator in self.indicatorViews) {
        [indicator removeFromSuperview];
    }
    
    NSUInteger indicatorCount = self.sequence.count + 1;
    self.indicatorViews = [NSMutableArray arrayWithCapacity:indicatorCount];
    
    const CGFloat indicatorDiameter = 8;
    CGFloat indicatorSpacing = self.bounds.size.width / (indicatorCount + 1);
    CGFloat y = (self.bounds.size.height - indicatorDiameter) / 2;
    for (size_t i = 0; i < indicatorCount; ++i) {
        UIView *indicator = [[UIView alloc] initWithFrame:CGRectMake(indicatorSpacing * (i + 1), y, indicatorDiameter, indicatorDiameter)];
        indicator.layer.cornerRadius = indicatorDiameter/2;
        indicator.layer.borderWidth = 1;
        indicator.layer.borderColor = self.indicatorColor.CGColor;
        [self.indicatorViews addObject:indicator];
        [self addSubview:indicator];
    }
    
    [self refreshIndicators];
}

- (void)refreshIndicators {
    for (size_t i = 0; i < self.indicatorViews.count; ++i) {
        UIView *indicator = self.indicatorViews[i];
        indicator.backgroundColor = (i >= self.numberCompleted) ? nil
                                                                : self.indicatorColor;
    }
}

@end
