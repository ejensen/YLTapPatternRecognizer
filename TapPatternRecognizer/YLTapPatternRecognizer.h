//
//  YLTapPatternRecognizer.h
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * UIGestureRecognizer subclass that looks for a sequence of taps that match a predefined pattern.
 */
@interface YLTapPatternRecognizer : UIGestureRecognizer

/**
 * Array of NSNumbers representing the relative interval between taps.
 * @note The default is [YLTapPatterns shaveAndAHaircut].
 */
@property (nonatomic, copy) NSArray<NSNumber *> *pattern;

/**
 * The minimum time required between touches in order for it to be considered a discrete tap.
 * @note The default value is 50 milliseconds.
 */
@property (nonatomic) NSTimeInterval minimumTapInterval;

/**
 * The maximum percentage of error allowed for pattern recognition.
 * @note The default value is 0.05 (5.0%).
 */
@property (nonatomic) double tolerance;

@end

/**
 * Contains a list of common tap patterns.
 */
@interface YLTapPatterns : NSObject
/**
 * http://en.wikipedia.org/wiki/Shave_and_a_Haircut
 */
+ (NSArray<NSNumber *> *)shaveAndAHaircut;

/**
 * http://en.wikipedia.org/wiki/Row,_Row,_Row_Your_Boat
 */
+ (NSArray<NSNumber *> *)rowRowRowYourBoat;

/**
 * http://en.wikipedia.org/wiki/A-Hunting_We_Will_Go
 */
+ (NSArray<NSNumber *> *)aHuntingWeWillGo;

@end

NS_ASSUME_NONNULL_END
