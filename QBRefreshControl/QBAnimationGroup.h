//
//  QBAnimationGroup.h
//  QBAnimationSequenceTest
//
//  Created by questbeat on 2012/09/29.
//  Copyright (c) 2012年 questbeat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QBAnimationItem;

@interface QBAnimationGroup : NSObject

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, assign) BOOL waitUntilDone;

+ (id)groupWithItem:(QBAnimationItem *)item;
+ (id)groupWithItems:(NSArray *)items;

- (id)initWithItem:(QBAnimationItem *)item;
- (id)initWithItems:(NSArray *)items;

@end
