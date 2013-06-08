//
//  QBArrowRefreshControl.m
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/11/22.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import "QBArrowRefreshControl.h"

@interface QBArrowRefreshControl ()

@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (weak, nonatomic, readonly) NSString *lastUpdateFormattedString;

@end

@implementation QBArrowRefreshControl

- (id)init
{
    self = [super init];
    
    if(self) {
        self.frame = CGRectMake(0, 0, 320, 60);
        self.threshold = -60;
        
        self.backgroundColor = [UIColor blackColor];
        
        self.lastUpdate = nil;
        
        // 矢印画像
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 50, 50)];
        arrowImageView.image = [UIImage imageNamed:@"arrow.png"];
        
        [self addSubview:arrowImageView];
        self.arrowImageView = arrowImageView;
        
        // インジケータ
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicatorView.frame = CGRectMake(35, 20, 20, 20);
        
        [self addSubview:activityIndicatorView];
        self.activityIndicatorView = activityIndicatorView;
        
        // タイトルラベル
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 7, 193, 21)];
        titleLabel.text = @"Pull to Refresh";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // 更新時間
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 193, 21)];
        timeLabel.text = @"Last Update: --";
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        timeLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
    }
    
    return self;
}


- (void)setState:(QBRefreshControlState)state
{
    [super setState:state];
    
    switch(state) {
        case QBRefreshControlStateHidden:
        {
            self.activityIndicatorView.hidden = YES;
            [self.activityIndicatorView stopAnimating];
            
            self.arrowImageView.hidden = NO;
        }
            break;
        case QBRefreshControlStatePullingDown:
        {
            self.titleLabel.text = @"Pull to Refresh";
            
            // 矢印を回転させる
            [UIView animateWithDuration:0.2 animations:^{
                self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
            break;
        case QBRefreshControlStateOveredThreshold:
        {
            self.titleLabel.text = @"Release to Refresh";
            
            // 矢印を回転させる
            [UIView animateWithDuration:0.2 animations:^{
                self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        case QBRefreshControlStateStopping:
        {
            self.activityIndicatorView.hidden = NO;
            [self.activityIndicatorView startAnimating];
            
            self.titleLabel.text = @"Loading...";
            
            self.arrowImageView.hidden = YES;
        }
            break;
    }
}

- (void)endRefreshing
{
    [super endRefreshing];
    
    self.lastUpdate = [NSDate date];
    self.timeLabel.text = [NSString stringWithFormat:@"Last Update: %@", self.lastUpdateFormattedString];
    
    // 矢印を回転させる
    self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
}


#pragma mark - Additions

- (NSString *)lastUpdateFormattedString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *formattedString = [dateFormatter stringFromDate:self.lastUpdate];
    
    
    return formattedString;
}

@end
