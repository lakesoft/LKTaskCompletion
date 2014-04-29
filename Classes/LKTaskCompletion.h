//
//  LKTaskCompletion.h
//  LKTaskCompletion
//
//  Created by Hiroshi Hashiguchi on 2014/04/29.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKTaskCompletion : NSObject

@property (assign, nonatomic) BOOL enabled; // default: YES

+ (instancetype)sharedInstance;
- (void)setup;
- (void)endBackgroundTask;

@end
