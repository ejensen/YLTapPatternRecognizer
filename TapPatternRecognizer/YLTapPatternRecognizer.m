//
//  YLTapPatternRecognizer.m
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import "YLTapPatternRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface YLTapPatternRecognizer () {
    NSMutableArray *_tapTimestamps;
    NSTimeInterval _lastTapTimestamp;
    NSTimeInterval _tapPatternDuration;
    NSUInteger _tapIndex;
}
@end

@implementation YLTapPatternRecognizer

@synthesize pattern = _pattern;

- (void)setPattern:(NSArray *)pattern
{
    _pattern = [pattern copy];
    _tapPatternDuration = [[pattern valueForKeyPath:@"@sum.self"] doubleValue];
    _tapTimestamps = [NSMutableArray arrayWithCapacity:pattern.count + 1];
}

- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        self.delaysTouchesEnded = NO;
        self.cancelsTouchesInView = NO;
        self.minimumTapInterval = 0.05;
        self.tolerance = 0.05;
        self.pattern = [YLTapPatterns shaveAndAHaircut];
    }
    return self;
}

- (void)reset {
    _tapIndex = 0;
    _lastTapTimestamp = 0;
    [_tapTimestamps removeAllObjects];
    [super reset];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_tapTimestamps.count < 1 || event.timestamp - _lastTapTimestamp > self.minimumTapInterval) {
        if (_tapTimestamps.count < self.pattern.count + 1) {
            [_tapTimestamps addObject:@(event.timestamp)];
        } else {
            _tapTimestamps[_tapIndex] = @(event.timestamp);
            _tapIndex = ++_tapIndex % _tapTimestamps.count;
        }
        
        _lastTapTimestamp = event.timestamp;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (_tapTimestamps.count > self.pattern.count && [self checkPattern]) {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateFailed;
}

- (BOOL)checkPattern {
    NSMutableArray *relativeIntervals = [NSMutableArray arrayWithCapacity:_tapTimestamps.count];
    NSTimeInterval totalDuration = 0;
    NSTimeInterval lastTap = [_tapTimestamps[_tapIndex] doubleValue];
    
    for (size_t i = 1; i < _tapTimestamps.count; ++i) {
        NSUInteger j = (_tapIndex + i) % _tapTimestamps.count;
        NSTimeInterval tap = [_tapTimestamps[j] doubleValue];
        NSTimeInterval interval = tap - lastTap;
        totalDuration += interval;
        [relativeIntervals addObject:@(interval)];
        lastTap = tap;
    }
    
    for (size_t i = 0; i < self.pattern.count; ++i) {
        NSTimeInterval intervalPercentage = [relativeIntervals[i] doubleValue] / totalDuration;
        NSTimeInterval patternPercentage = [self.pattern[i] doubleValue] / _tapPatternDuration;
        
        if (fabs(intervalPercentage - patternPercentage) > self.tolerance) {
            return NO;
        }
    }
    return YES;
}

@end


@implementation YLTapPatterns

+ (NSArray *)shaveAndAHaircut {
    return @[ @2, @1, @1, @2, @4, @2 ];
}

+ (NSArray *)rowRowRowYourBoat {
    return @[ @3, @3, @3, @1, @3, @2, @2, @2, @2 ];
}

+ (NSArray *)aHuntingWeWillGo {
    return @[ @1, @2, @1, @2 , @1, @4, @1, @2, @1, @2 , @1 ];
}

@end
