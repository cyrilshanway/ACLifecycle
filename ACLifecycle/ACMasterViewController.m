//
//  MasterViewController.m
//  ACLifecycle
//
//  Created by Edward Chiang on 2014/11/4.
//  Copyright (c) 2014年 Soleil Studio. All rights reserved.
//

#import "ACMasterViewController.h"
#import "ACDetailViewController.h"

@interface ACMasterViewController ()

@property NSMutableArray *objects;
@end

@implementation ACMasterViewController

- (void)awakeFromNib {
  [super awakeFromNib];
  NSLog(@"%@ awakeFromNib", NSStringFromClass([self class]));
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      self.clearsSelectionOnViewWillAppear = NO;
      self.preferredContentSize = CGSizeMake(320.0, 600.0);
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"%@ viewDidLoad", NSStringFromClass([self class]));
  // Do any additional setup after loading the view, typically from a nib.
  self.navigationItem.leftBarButtonItem = self.editButtonItem;

  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
  self.navigationItem.rightBarButtonItem = addButton;
  self.detailViewController = (ACDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
  //********************* 註冊notification *********************//
  if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  NSLog(@"%@ viewWillAppear", NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  NSLog(@"%@ viewDidAppear", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  NSLog(@"%@ viewWillDisappear", NSStringFromClass([self class]));
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  NSLog(@"%@ viewDidLayoutSubviews", NSStringFromClass([self class]));
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  NSLog(@"%@ viewWillLayoutSubviews", NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  NSLog(@"%@ didReceiveMemoryWarning", NSStringFromClass([self class]));
}

- (void)insertNewObject:(id)sender {
  if (!self.objects) {
      self.objects = [[NSMutableArray alloc] init];
  }
  
  NSDate *now = [NSDate date];
  [self.objects insertObject:now atIndex:0];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
  
  [self schedulLocalNotification:now afterMintue:1 indexPath:indexPath];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"showDetail"]) {
      NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      NSDate *object = self.objects[indexPath.row];
      ACDetailViewController *controller = (ACDetailViewController *)[[segue destinationViewController] topViewController];
      [controller setDetailItem:object];
      controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
      controller.navigationItem.leftItemsSupplementBackButton = YES;
  }
}

#pragma mark - private
//******************************* push notification ************************************//
- (void)schedulLocalNotification:(NSDate *)now afterMintue:(NSInteger)minute indexPath:(NSIndexPath *)indexPath {
  // Schedule a local notification
  NSCalendar *calendar = [[NSCalendar alloc]
                          initWithCalendarIdentifier:NSGregorianCalendar];
  NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
  [offsetComponents setMinute:minute];
  // Calculate when, according to Tom Lehrer, World War III will end
  NSDate *oneMoreMinute = [calendar dateByAddingComponents:offsetComponents toDate:now options:0];
  NSLog(@"One more Minute date %@", oneMoreMinute);
  
  NSUInteger scheduledNotificationsCount = [[UIApplication sharedApplication] scheduledLocalNotifications].count;
  NSLog(@"We have %lu local notifcations.", scheduledNotificationsCount);

  UILocalNotification *remindUserFromNotify = [[UILocalNotification alloc] init];
  remindUserFromNotify.fireDate = oneMoreMinute;
  remindUserFromNotify.alertBody = NSLocalizedString(@"After one mintute", @"Remind me after 1 min.");
  remindUserFromNotify.soundName = UILocalNotificationDefaultSoundName;
  remindUserFromNotify.applicationIconBadgeNumber = scheduledNotificationsCount + 1;
  remindUserFromNotify.userInfo = @{@"FireDate":oneMoreMinute, @"Index": [NSNumber numberWithInteger:indexPath.row]};
  
  [[UIApplication sharedApplication] scheduleLocalNotification:remindUserFromNotify];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

  NSDate *object = self.objects[indexPath.row];
  cell.textLabel.text = [object description];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  // Return NO if you do not want the specified item to be editable.
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
      [self.objects removeObjectAtIndex:indexPath.row];
      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
  }
}

@end
