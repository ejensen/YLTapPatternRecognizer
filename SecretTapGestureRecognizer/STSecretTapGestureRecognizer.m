//
//  STSecretTapGestureRecognizer.m
//  SecretTapGestureRecognizer
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import "STSecretTapGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

@interface STSecretTapGestureRecognizer () {
    NSTimeInterval _secretTapDuration;
    NSTimeInterval _lastTapTimestamp;
    NSUInteger _tapIndex;
}

@property (nonatomic, strong) NSMutableArray *tapTimestamps;

@end

@implementation STSecretTapGestureRecognizer

@synthesize secretPattern = _secretTapPattern;

- (void)setSecretPattern:(NSArray *)secretTapPattern
{
    if (secretTapPattern != _secretTapPattern) {
        _secretTapPattern = secretTapPattern;
        _secretTapDuration = 0;
        for (NSNumber *interval in secretTapPattern) {
            _secretTapDuration += [interval doubleValue];
        }
        self.tapTimestamps = [NSMutableArray arrayWithCapacity:secretTapPattern.count + 1];
    }
}

- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        self.delaysTouchesEnded = NO;
        self.cancelsTouchesInView = NO;
        self.minimumTapInterval = 0.05;
        self.tolerance = 0.05;
        // Default is "Shave and a haircut, two bits" http://en.wikipedia.org/wiki/Shave_and_a_Haircut
        self.secretPattern = @[@(2), @(1), @(1), @(2), @(4), @(2)];
    }
    return self;
}

- (void)reset {
    _tapIndex = 0;
    _lastTapTimestamp = 0;
    [self.tapTimestamps removeAllObjects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.tapTimestamps.count < 1 || event.timestamp - _lastTapTimestamp > self.minimumTapInterval) {
        if (self.tapTimestamps.count < self.secretPattern.count + 1) {
            [self.tapTimestamps addObject:@(event.timestamp)];
        } else {
            self.tapTimestamps[_tapIndex] = @(event.timestamp);
            _tapIndex = ++_tapIndex % self.tapTimestamps.count;
        }
        
        _lastTapTimestamp = event.timestamp;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (self.tapTimestamps.count > self.secretPattern.count && [self checkPattern]) {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateFailed;
}

- (BOOL)checkPattern {
    NSMutableArray *relativeIntervals = [NSMutableArray arrayWithCapacity:self.tapTimestamps.count - 1];
    NSTimeInterval totalDuration = 0;
    NSTimeInterval lastTap = [self.tapTimestamps[_tapIndex] doubleValue];
    
    for (NSUInteger i = 1; i < self.tapTimestamps.count; ++i) {
        NSUInteger j = (_tapIndex + i) % self.tapTimestamps.count;
        NSTimeInterval tap = [self.tapTimestamps[j] doubleValue];
        NSTimeInterval interval = tap - lastTap;
        totalDuration += interval;
        [relativeIntervals addObject:@(interval)];
        lastTap = tap;
    }
    
    for (NSUInteger i = 0; i < self.secretPattern.count; ++i) {
        NSTimeInterval intervalPercentage = [relativeIntervals[i] doubleValue] / totalDuration;
        NSTimeInterval patternPercentage = [self.secretPattern[i] doubleValue] / _secretTapDuration;
        
        if (fabs(intervalPercentage - patternPercentage) > self.tolerance) {
            return NO;
        }
    }
    return YES;
}

@end
