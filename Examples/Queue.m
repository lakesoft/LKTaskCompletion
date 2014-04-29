//
//  Queue.m
//  LKTaskCompletion
//
//  Created by Hiroshi Hashiguchi on 2014/04/29.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "Queue.h"

@interface Queue()
@property (strong, nonatomic) NSMutableArray* queue;
@end

@implementation Queue

- (id)init {
    self = [super init];
    if (self) {
        self.queue = [NSMutableArray array];
    }
    return self;
}

- (void)putObject:(id)object
{
    @synchronized (self) {
        [self.queue addObject:object];
    }
}

- (id)getObject
{
    @synchronized (self) {
        if ([self.queue count] > 0) {
            return [self.queue objectAtIndex:0];
        } else {
            return nil;
        }
    }
}

- (void)removeObject
{
    @synchronized (self) {
        if ([self.queue count] > 0) {
            [self.queue removeObjectAtIndex:0];
        }
    }
}

- (NSUInteger)count
{
    return [self.queue count];
}

- (NSArray*)list
{
    return self.queue;
}
@end
