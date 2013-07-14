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

#pragma mark - Properties

@synthesize indicatorColor = _indicatorColor;
@synthesize total = _total;
@synthesize completed = _completed;

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    if ([indicatorColor isEqual:_indicatorColor]) {
        _indicatorColor = indicatorColor;
        [self refreshIndicators];
    }
}

- (void)setTotal:(NSUInteger)total {
    _total = total;
    [self layoutIndictors];
}

- (void)setCompleted:(NSUInteger)completed {
    if (completed != _completed) {
        _completed = completed;
        [self refreshIndicators];
    }
}

#pragma mark - Initialization

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

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIndictors];
}

- (void)layoutIndictors {
    self.completed = 0;
    
    [self.indicatorViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger indicatorCount = self.total + 1;
    self.indicatorViews = [NSMutableArray arrayWithCapacity:indicatorCount];
    
    const CGFloat indicatorRadius = 8;
    const CGFloat indicatorDiameter = indicatorRadius * 2;
    const CGFloat borderWidth = indicatorRadius / 4;
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = fminf(center.x, center.y) - indicatorDiameter;
    
    CGFloat step = M_PI * 2 / indicatorCount;
    for (size_t i = 0; i < indicatorCount; ++i) {
        UIView *indicator = [[UIView alloc] initWithFrame:CGRectMake(center.x - indicatorRadius + radius * sinf(i * step),
                                                                     center.y - indicatorRadius + radius * -cosf(i * step),
                                                                     indicatorDiameter,
                                                                     indicatorDiameter)];
        indicator.layer.cornerRadius = indicatorRadius;
        indicator.layer.borderWidth = borderWidth;
        indicator.layer.borderColor = self.indicatorColor.CGColor;
        [self.indicatorViews addObject:indicator];
        [self addSubview:indicator];
    }
    
    [self refreshIndicators];
}

- (void)refreshIndicators {
    [self.indicatorViews makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:nil];
    [self.indicatorViews[self.completed % self.indicatorViews.count] setBackgroundColor:self.indicatorColor];
}

@end
