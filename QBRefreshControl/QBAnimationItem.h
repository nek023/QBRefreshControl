//
//  QBAnimationItem.h
//  QBAnimationSequenceTest
//
//  Created by questbeat on 2012/09/29.
//  Copyright (c) 2012年 questbeat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^QBAnimationBlock)(void);

@interface QBAnimationItem : NSObject

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat delay;
@property (nonatomic, assign) UIViewAnimationOptions options;
@property (nonatomic, copy) QBAnimationBlock animations;

+ (id)itemWithDuration:(CGFloat)duration delay:(CGFloat)delay options:(UIViewAnimationOptions)options animations:(QBAnimationBlock)animations;
- (id)initWithDuration:(CGFloat)duration delay:(CGFloat)delay options:(UIViewAnimationOptions)options animations:(QBAnimationBlock)animations;

@end
