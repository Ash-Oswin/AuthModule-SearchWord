//
//  ClickAnimationButton.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/28.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "ClickAnimationButton.h"


@implementation ClickAnimationButton


- (instancetype)init {
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(setButtonAnimation:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(cancelButtonAnimation:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [self.layer setCornerRadius:4];
        self.layer.masksToBounds = TRUE;
    }
    return self;
}


#pragma mark --设置按钮点击与松开的动画


- (void)setButtonAnimation:(UIButton *)button {
    button.alpha = 0.3;
}


- (void)cancelButtonAnimation:(UIButton *)button {
    button.alpha = 1.0;
}


@end
