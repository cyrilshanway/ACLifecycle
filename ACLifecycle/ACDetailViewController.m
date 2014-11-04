//
//  DetailViewController.m
//  ACLifecycle
//
//  Created by Edward Chiang on 2014/11/4.
//  Copyright (c) 2014年 Soleil Studio. All rights reserved.
//

#import "ACDetailViewController.h"

@interface ACDetailViewController ()

@end

@implementation ACDetailViewController

#pragma mark - Managing the detail item

- (void)awakeFromNib {
  NSLog(@"%@ viewDidLoad", NSStringFromClass([self class]));
}

- (void)setDetailItem:(id)newDetailItem {
  if (_detailItem != newDetailItem) {
      _detailItem = newDetailItem;
          
      // Update the view.
      [self configureView];
  }
}

- (void)configureView {
  // Update the user interface for the detail item.
  if (self.detailItem) {
      self.detailDescriptionLabel.text = [self.detailItem description];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self configureView];
  NSLog(@"%@ viewDidLoad", NSStringFromClass([self class]));
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

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  NSLog(@"%@ viewWillLayoutSubviews", NSStringFromClass([self class]));
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  NSLog(@"%@ viewDidLayoutSubviews", NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  NSLog(@"%@ didReceiveMemoryWarning", NSStringFromClass([self class]));
}

@end
