//
//  SyncDemoViewController.m
//  QBRefreshControlDemo
//
//  Created by Katsuma Tanaka on 2012/12/08.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

#import "SyncDemoViewController.h"

@interface SyncDemoViewController ()

@property (nonatomic, retain) QBSimpleSyncRefreshControl *myRefreshControl;

@end

@implementation SyncDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Refresh Control
    QBSimpleSyncRefreshControl *refreshControl = [[QBSimpleSyncRefreshControl alloc] init];
    refreshControl.delegate = self;
    [self.tableView addSubview:refreshControl];
    self.myRefreshControl = refreshControl;
    [refreshControl release];
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
