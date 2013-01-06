//
//  QBAnimationSequence.h
//  QBAnimationSequenceTest
//
//  Created by questbeat on 2012/09/29.
//  Copyright (c) 2012年 questbeat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    QBAnimationSequenceStatePlaying,
    QBAnimationSequenceStateStopped
} QBAnimationSequenceState;

@interface QBAnimationSequence : NSObject
{
    BOOL _running;
    NSUInteger _currentGroup;
    NSUInteger _finishedCount;
}

@property (nonatomic, copy) NSArray *groups;
@property (nonatomic, assign) BOOL repeat;

- (id)initWithAnimationGroups:(NSArray *)groups;
- (id)initWithAnimationGroups:(NSArray *)groups repeat:(BOOL)repeat;

- (void)start;
- (void)stop;
- (void)performNextGroup;
- (void)animationFinished;

@end
