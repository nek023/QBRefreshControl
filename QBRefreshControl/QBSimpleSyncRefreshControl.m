//
//  QBSimpleSyncRefreshControl.m
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/11/23.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import "QBSimpleSyncRefreshControl.h"

#import "QBAnimationSequence.h"
#import "QBAnimationGroup.h"
#import "QBAnimationItem.h"

@interface QBSimpleSyncRefreshControl ()
{
    QBAnimationSequence *_sequence;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, assign) CGFloat angle;

@end

@implementation QBSimpleSyncRefreshControl

- (id)init
{
    self = [super init];
    
    if(self) {
        self.frame = CGRectMake(0, 0, 320, 80);
        self.threshold = -80;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.angle = 0;
        
        // 画像
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 10, 60, 60)];
        imageView.image = [UIImage imageNamed:@"sync.png"];
        
        [self addSubview:imageView];
        self.imageView = imageView;
        
        // QBAnimationSequence
        QBAnimationItem *item = [QBAnimationItem itemWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
            imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI/2);
        }];
        
        QBAnimationGroup *group = [QBAnimationGroup groupWithItems:@[item]];
        
        _sequence = [[QBAnimationSequence alloc] initWithAnimationGroups:@[group] repeat:YES];
                
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
            break;
        case QBRefreshControlStatePullingDown:
        case QBRefreshControlStateOveredThreshold:
        {
            CGPoint contentOffset = self.scrollView.contentOffset;
            
            CGFloat angle = contentOffset.y * 180.0 / M_PI * 0.001;
            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, self.angle - angle);
            
            self.angle = angle;
        }
            break;
        case QBRefreshControlStateStopping:
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
