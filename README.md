LKTaskCompletion
================

Task Completion Utility

##Usage

1. Setup

    #import "LKTaskCompletion.h"

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        [LKTaskCompletion.sharedInstance setup];
            :
    }

2. When your task has finished

Call endBackgroundTask method.

    [LKTaskCompletion.sharedInstance endBackgroundTask];

3. Etc

If you want to be disable background task, use enabled property.

    LKTaskCompletion.sharedInstance.enabled = NO;


## Installation

The library is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "LKTaskCompletion", :git => 'https://github.com/lakesoft/LKTaskCompletion.git'

## Author

Hiroshi Hashiguchi, xcatsan@mac.com

## License

The library is available under the MIT license. See the LICENSE file for more info.
