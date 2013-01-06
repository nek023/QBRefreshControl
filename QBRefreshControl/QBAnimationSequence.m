//
//  QBAnimationSequence.m
//  QBAnimationSequenceTest
//
//  Created by questbeat on 2012/09/29.
//  Copyright (c) 2012年 questbeat. All rights reserved.
//

#import "QBAnimationSequence.h"

#import "QBAnimationGroup.h"
#import "QBAnimationItem.h"

@implementation QBAnimationSequence

- (id)init
{
    self = [super init];
    
    if(self) {
        self.groups = nil;
        self.repeat = NO;
        
        _running = NO;
    }
    
    return self;
}

- (id)initWithAnimationGroups:(NSArray *)groups
{
    self = [self init];
    
    if(self) {
        self.groups = groups;
    }
    
    return self;
}

- (id)initWithAnimationGroups:(NSArray *)groups repeat:(BOOL)repeat
{
    self = [self init];
    
    if(self) {
        self.groups = groups;
        self.repeat = repeat;
    }
    
    return self;
}

- (void)dealloc
{
    [_groups release];
    
    [super dealloc];
}

- (void)start
{
    if(_running)
        return;
    
    _running = YES;
    
    _currentGroup = 0;
    _finishedCount = 0;
    
    [self performNextGroup];
}

- (void)stop
{
    _running = NO;
}

- (void)performNextGroup
{
    if(!_running)
        return;
    
    if(_currentGroup >= self.groups.count) {
        if(self.repeat) {
            _running = NO;
            [self start];
        }
        
        return;
    }
    
    QBAnimationGroup *group = (QBAnimationGroup *)[self.groups objectAtIndex:_currentGroup];
    
    for(NSInteger i = 0; i < group.items.count; i++) {
        QBAnimationItem *item = (QBAnimationItem *)[group.items objectAtIndex:i];
        
        if(group.waitUntilDone) {
            [UIView animateWithDuration:item.duration delay:item.delay options:item.options animations:item.animations completion:^(BOOL finished) {
                [self animationFinished];
            }];
        } else {
            [UIView animateWithDuration:item.duration delay:item.delay options:item.options animations:item.animations completion:nil];
        }
    }
    
    if(!group.waitUntilDone) {
        _currentGroup++;
        [self performNextGroup];
    }
}

- (void)animationFinished
{
    _finishedCount++;
    
    QBAnimationGroup *group = (QBAnimationGroup *)[self.groups objectAtIndex:_currentGroup];
    
    if(_finishedCount == group.items.count) {
        _finishedCount = 0;
        
        _currentGroup++;
        [self performNextGroup];
    }
}

@end
