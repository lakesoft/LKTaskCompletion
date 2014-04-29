//
//  LKTaskCompletion.m
//  LKTaskCompletion
//
//  Created by Hiroshi Hashiguchi on 2014/04/29.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "LKTaskCompletion.h"

@interface LKTaskCompletion()
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifer;
@end

@implementation LKTaskCompletion

#pragma mark - Privates

- (void)_willResignActive:(NSNotification*)notification
{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (!self.enabled) {
        return;
    }

    NSAssert(self.backgroundTaskIdentifer == UIBackgroundTaskInvalid, nil);
    
    self.backgroundTaskIdentifer = [UIApplication.sharedApplication
                                    beginBackgroundTaskWithExpirationHandler:^{
//                                        NSLog(@"expired!");
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            if (self.backgroundTaskIdentifer != UIBackgroundTaskInvalid) {
                                                [UIApplication.sharedApplication endBackgroundTask:self.backgroundTaskIdentifer];
                                                self.backgroundTaskIdentifer = UIBackgroundTaskInvalid;
                                            }
                                        });
                                    }];
}

- (void)_didBecomeActive:(NSNotification*)notification
{
//    NSLog(@"%s", __PRETTY_FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.backgroundTaskIdentifer != UIBackgroundTaskInvalid) {
            [UIApplication.sharedApplication endBackgroundTask:self.backgroundTaskIdentifer];
            self.backgroundTaskIdentifer = UIBackgroundTaskInvalid;
        }
    });
}

#pragma mark - Basics
- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.enabled = YES;
    }
    return self;
}

#pragma mark - API

+ (instancetype)sharedInstance
{
    static LKTaskCompletion* _sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = self.new;
    });
    return _sharedInstance;
}

- (void)setup
{
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_willResignActive:)
                                               name:UIApplicationWillResignActiveNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_didBecomeActive:)
                                               name:UIApplicationDidBecomeActiveNotification
                                             object:nil];
}

- (void)endBackgroundTask
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.backgroundTaskIdentifer != UIBackgroundTaskInvalid) {
            [UIApplication.sharedApplication endBackgroundTask:self.backgroundTaskIdentifer];
            self.backgroundTaskIdentifer = UIBackgroundTaskInvalid;
        }
    });
}


@end
