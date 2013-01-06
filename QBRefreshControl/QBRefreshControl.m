//
//  QBRefreshControl.m
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/11/22.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import "QBRefreshControl.h"

@interface QBRefreshControl ()

@property (nonatomic, assign) BOOL dragging;

@end

@implementation QBRefreshControl

- (id)init
{
    self = [super init];
    
    if(self) {
        self.threshold = -60;
        self.state = QBRefreshControlStateHidden;
        
        self.dragging = NO;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y = 0 - frame.size.height;
    
    [super setFrame:frame];
}

- (UIScrollView *)scrollView
{
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    
    if(![scrollView isKindOfClass:[UIScrollView class]])
        scrollView = nil;
    
    return scrollView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if(self.scrollView != nil) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    if([newSuperview isKindOfClass:[UIScrollView class]]) {
        self.frame = CGRectMake(0, 0 - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        
        [newSuperview addObserver:self
                       forKeyPath:@"contentOffset"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *scrollView = (UIScrollView *)object;
        
        if(self.dragging != scrollView.dragging) {
            if(!scrollView.dragging) {
                [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
            }
            
            self.dragging = scrollView.dragging;
        }
        
        [self scrollViewDidScroll:scrollView];
    }
}


#pragma mark - Refresh Control

- (void)beginRefreshing
{
    if([self.delegate respondsToSelector:@selector(refreshControlWillBeginRefreshing:)]) {
        [self.delegate refreshControlWillBeginRefreshing:self];
    }
    
    self.state = QBRefreshControlStateStopping;
    
    UIScrollView *scrollView = self.scrollView;
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(0 - self.threshold, 0, 0, 0);
    } completion:NULL];
    
    if([self.delegate respondsToSelector:@selector(refreshControlDidBeginRefreshing:)]) {
        [self.delegate refreshControlDidBeginRefreshing:self];
    }
}

- (void)endRefreshing
{
    if([self.delegate respondsToSelector:@selector(refreshControlWillEndRefreshing:)]) {
        [self.delegate refreshControlWillEndRefreshing:self];
    }
    
    UIScrollView *scrollView = self.scrollView;
    
    if(scrollView.contentOffset.y < 0) {
        CGPoint offset = scrollView.contentOffset;
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [scrollView setContentOffset:offset animated:NO];
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            scrollView.contentOffset = CGPointMake(0, 0);
        } completion:NULL];
    } else {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    self.state = QBRefreshControlStateHidden;
    
    if([self.delegate respondsToSelector:@selector(refreshControlDidEndRefreshing:)]) {
        [self.delegate refreshControlDidEndRefreshing:self];
    }
}


#pragma mark - UIScrollViewDelegate (Detected by observing value changes)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.state == QBRefreshControlStateStopping) return;
    
    if(self.threshold <= scrollView.contentOffset.y && scrollView.contentOffset.y < 0) {
        self.state = QBRefreshControlStatePullingDown;
    } else if(scrollView.contentOffset.y < self.threshold) {
        self.state = QBRefreshControlStateOveredThreshold;
    } else {
        self.state = QBRefreshControlStateHidden;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.state == QBRefreshControlStateStopping) return;
    
    if(self.state == QBRefreshControlStateOveredThreshold) {
        if(scrollView.contentOffset.y < self.threshold) {
            [scrollView setContentOffset:scrollView.contentOffset animated:NO];
        }
        
        [self beginRefreshing];
    }
}

@end
