//
//  Queue.h
//  LKTaskCompletion
//
//  Created by Hiroshi Hashiguchi on 2014/04/29.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Queue : NSObject

- (void)putObject:(id)object;
- (id)getObject;
- (void)removeObject;
- (NSUInteger)count;
- (NSArray*)list;

@end
