//
//  BindAccoutView.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/23.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "BindAccoutView.h"


@interface BindAccoutView ()

@end


@implementation BindAccoutView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"账号绑定";

    CGFloat passwordFieldY = CGRectGetMaxY(self.accountField.frame) + 15;
    CGRect passwordFieldFrame = self.passwordField.frame;
    passwordFieldFrame.origin.y = passwordFieldY;
    self.passwordField.frame = passwordFieldFrame;
        
    [self.captchaTextField removeFromSuperview];
    [self.captchaButton removeFromSuperview];
    
    CGFloat errorTipsY = CGRectGetMaxY(self.passwordField.frame) + 8;
    CGRect errorTipsFrame = self.errorTips.frame;
    errorTipsFrame.origin.y = errorTipsY;
    self.errorTips.frame = errorTipsFrame;

    CGFloat forgetPasswordY = errorTipsY;
    CGRect forgetPasswordFrame = self.forgetPassword.frame;
    forgetPasswordFrame.origin.y = forgetPasswordY;
    self.forgetPassword.frame = forgetPasswordFrame;

    CGFloat actionButtonY = CGRectGetMaxY(self.passwordField.frame) + 40;
    CGRect actionButtonFrame = self.actionButton.frame;
    actionButtonFrame.origin.y = actionButtonY;
    self.actionButton.frame = actionButtonFrame;
    [self.actionButton setTitle:@"绑定" forState:UIControlStateNormal];

    CGFloat userNoticeY = CGRectGetMaxY(self.actionButton.frame) + 10;
    CGRect userNoticeFrame = self.userNotice.frame;
    userNoticeFrame.origin.y = userNoticeY;
    self.userNotice.frame = userNoticeFrame;
}


@end
