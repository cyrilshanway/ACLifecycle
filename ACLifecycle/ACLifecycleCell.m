//
//  ACLifecycleCell.m
//  ACLifecycle
//
//  Created by Edward Chiang on 2014/11/5.
//  Copyright (c) 2014年 Soleil Studio. All rights reserved.
//

#import "ACLifecycleCell.h"

@implementation ACLifecycleCell

- (void)awakeFromNib {
    // Initialization code
  NSLog(@"%@ awakeFromNib", NSStringFromClass([self class]));
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  NSLog(@"%@ drawRect", NSStringFromClass([self class]));
}

- (void)layoutSubviews {
  [super layoutSubviews];
  NSLog(@"%@ layoutSubviews", NSStringFromClass([self class]));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
