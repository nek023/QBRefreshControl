//
//  QBFunnyFaceRefreshControl.m
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/11/23.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import "QBFunnyFaceRefreshControl.h"

#import "QBAnimationSequence.h"
#import "QBAnimationGroup.h"
#import "QBAnimationItem.h"

@interface QBFunnyFaceRefreshControl ()
{
    QBAnimationSequence *_sequence;
}

@property (nonatomic, retain) UIImageView *imageView;

@end

@implementation QBFunnyFaceRefreshControl

- (id)init
{
    self = [super init];
    
    if(self) {
        self.frame = CGRectMake(0, 0, 320, 100);
        self.threshold = -100;
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 画像
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        imageView.image = [UIImage imageNamed:@"face_yey.png"];
        
        [self addSubview:imageView];
        self.imageView = imageView;
        
        // QBAnimationSequence
        QBAnimationItem *item1 = [QBAnimationItem itemWithDuration:0.04 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
            imageView.frame = CGRectMake(-4, 0, 320, 100);
        }];
        
        QBAnimationItem *item2 = [QBAnimationItem itemWithDuration:0.04 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
            imageView.frame = CGRectMake(4, 0, 320, 100);
        }];
        
        QBAnimationItem *item3 = [QBAnimationItem itemWithDuration:0.04 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
            imageView.frame = CGRectMake(0, 0, 320, 100);
        }];
        
        QBAnimationGroup *group1 = [QBAnimationGroup groupWithItems:@[item1, item3]];
        QBAnimationGroup *group2 = [QBAnimationGroup groupWithItems:@[item2, item3]];
        
        _sequence = [[QBAnimationSequence alloc] initWithAnimationGroups:@[group1, group2] repeat:YES];
        
        [imageView release];
    }
    
    return self;
}

- (void)dealloc
{
    [_imageView release];
    [_sequence release];
    
    [super dealloc];
}

- (void)setState:(QBRefreshControlState)state
{
    [super setState:state];
    
    switch(state) {
        case QBRefreshControlStateHidden:
        {
            self.imageView.image = [UIImage imageNamed:@"face_hi.png"];
        }
            break;
        case QBRefreshControlStatePullingDown:
        {
            self.imageView.image = [UIImage imageNamed:@"face_hi.png"];
        }
            break;
        case QBRefreshControlStateOveredThreshold:
        {
            self.imageView.image = [UIImage imageNamed:@"face_wat.png"];
        }
            break;
        case QBRefreshControlStateStopping:
        {
            self.imageView.image = [UIImage imageNamed:@"face_ffffuuuu.png"];
        }
            break;
    }
}

- (void)beginRefreshing
{
    [super beginRefreshing];
    
    [_sequence start];
}

- (void)endRefreshing
{
    [super endRefreshing];
    
    [_sequence stop];
}

@end
