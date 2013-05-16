//
//  STSecretTapGestureRecognizer.h
//  SecretTapGestureRecognizer
//
//  Created by Eric Jensen on 5/15/13.
//  Copyright (c) 2013 Yeti Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STSecretTapGestureRecognizer : UIGestureRecognizer

@property (nonatomic, copy) NSArray *secretPattern;
@property (nonatomic, assign) NSTimeInterval minimumTapInterval;
@property (nonatomic, assign) double tolerance;

@end
