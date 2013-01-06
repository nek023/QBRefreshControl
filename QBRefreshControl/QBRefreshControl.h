//
//  QBRefreshControl.h
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/11/22.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBRefreshControl;

// HeaderViewState
typedef enum {
    QBRefreshControlStateHidden,
    QBRefreshControlStatePullingDown,
    QBRefreshControlStateOveredThreshold,
    QBRefreshControlStateStopping
} QBRefreshControlState;

@protocol QBRefreshControlDelegate <NSObject>

@optional
- (void)refreshControlWillBeginRefreshing:(QBRefreshControl *)refreshControl;
- (void)refreshControlDidBeginRefreshing:(QBRefreshControl *)refreshControl;
- (void)refreshControlWillEndRefreshing:(QBRefreshControl *)refreshControl;
- (void)refreshControlDidEndRefreshing:(QBRefreshControl *)refreshControl;

@end

@interface QBRefreshControl : UIView

@property (nonatomic, assign) id<QBRefreshControlDelegate> delegate;
@property (nonatomic, assign) CGFloat threshold;
@property (nonatomic, assign) QBRefreshControlState state;
@property (nonatomic, readonly) UIScrollView *scrollView;

// Refresh Control
- (void)beginRefreshing;
- (void)endRefreshing;

// UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
