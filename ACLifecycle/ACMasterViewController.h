//
//  MasterViewController.h
//  ACLifecycle
//
//  Created by Edward Chiang on 2014/11/4.
//  Copyright (c) 2014年 Soleil Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACDetailViewController;

@interface ACMasterViewController : UITableViewController

@property (strong, nonatomic) ACDetailViewController *detailViewController;


@end

