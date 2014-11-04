//
//  DetailViewController.h
//  ACLifecycle
//
//  Created by Edward Chiang on 2014/11/4.
//  Copyright (c) 2014年 Soleil Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

