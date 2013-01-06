//
//  QBAnimationGroup.m
//  QBAnimationSequenceTest
//
//  Created by questbeat on 2012/09/29.
//  Copyright (c) 2012年 questbeat. All rights reserved.
//

#import "QBAnimationGroup.h"

#import "QBAnimationItem.h"

@implementation QBAnimationGroup

- (id)init
{
    self = [super init];
    
    if(self) {
        self.items = nil;
        self.waitUntilDone = YES;
    }
    
    return self;
}

+ (id)groupWithItem:(QBAnimationItem *)item
{
    return [[[self alloc] initWithItem:item] autorelease];
}

+ (id)groupWithItems:(NSArray *)items
{
    return [[[self alloc] initWithItems:items] autorelease];
}

- (id)initWithItem:(QBAnimationItem *)item
{
    self = [self init];
    
    if(self) {
        self.items = [NSArray arrayWithObject:item];
    }
    
    return self;
}

- (id)initWithItems:(NSArray *)items
{
    self = [self init];
    
    if(self) {
        self.items = items;
    }
    
    return self;
}

- (void)dealloc
{
    [_items release];
    
    [super dealloc];
}

@end
