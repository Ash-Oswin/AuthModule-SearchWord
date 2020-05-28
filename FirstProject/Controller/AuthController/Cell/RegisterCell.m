//
//  TestCell.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/23.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "RegisterCell.h"


@implementation RegisterCell


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setFrame:(CGRect)frame {
    frame.origin.y += 15;
    [super setFrame:frame];
}


@end
