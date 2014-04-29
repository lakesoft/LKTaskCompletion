//
//  TableViewController.m
//  LKTaskCompletion
//
//  Created by Hiroshi Hashiguchi on 2014/04/29.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//
#import "TableViewController.h"
#import "Queue.h"
#import "LKTaskCompletion.h"
#import "Cell.h"

@interface TableViewController ()
@property (strong, nonatomic) Queue* queue;
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    LKTaskCompletion.sharedInstance.enabled = NO; // if you disable background task

    self.queue = [[Queue alloc] init];
    for (int i=0; i < 15; i++) {
        NSString* str = [NSString stringWithFormat:@"DATA-%02d", i];
        [self.queue putObject:str];
    }
    
    dispatch_queue_t gcd_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(gcd_queue, ^{
        
        UIApplication* app = [UIApplication sharedApplication];
        app.applicationIconBadgeNumber = self.queue.count;
        for(;;) {
            if (self.queue.count > 0) {
                id object = self.queue.getObject;
                NSLog(@"processing: %@", object);
                [NSThread sleepForTimeInterval:1.0];    // dummy wait
                NSLog(@"done: %@", object);
                [self.queue removeObject];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    app.applicationIconBadgeNumber = self.queue.count;
                    [self.tableView reloadData];
                });
                
                if (self.queue.count == 0) {
                    NSLog(@"finished!");
                    [LKTaskCompletion.sharedInstance endBackgroundTask];
                }
            } else {
                [NSThread sleepForTimeInterval:1.0];
            }
        }
        
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addQueue:(id)sender {
    [self.queue putObject:NSDate.date.description];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.queue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.queue.list objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        [cell.indicator startAnimating];
    } else {
        [cell.indicator stopAnimating];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
