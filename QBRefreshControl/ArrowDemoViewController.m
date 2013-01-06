//
//  ArrowDemoViewController.m
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/12/08.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import "ArrowDemoViewController.h"

@interface ArrowDemoViewController ()

@property (nonatomic, retain) QBArrowRefreshControl *myRefreshControl;

@end

@implementation ArrowDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Black Background
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -400, 320, 400)];
    bgView.backgroundColor = [UIColor blackColor];
    [self.tableView addSubview:bgView];
    [bgView release];
    
    // Refresh Control
    QBArrowRefreshControl *refreshControl = [[QBArrowRefreshControl alloc] init];
    refreshControl.delegate = self;
    [self.tableView addSubview:refreshControl];
    self.myRefreshControl = refreshControl;
    [refreshControl release];
    
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - QBRefreshControlDelegate

- (void)refreshControlDidBeginRefreshing:(QBRefreshControl *)refreshControl
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.myRefreshControl endRefreshing];
    });
}

@end
