////
////  LoginViewController.m
////  FirstProject
////
////  Created by 谢政 on 2020/5/19.
////  Copyright © 2020 maimemo. All rights reserved.
////

#import "ElseLoginView.h"
#import "AuthExample.h"
#import "RegisterView.h"


@interface ElseLoginView ()

@end


@implementation ElseLoginView


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [skipButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(jumpToRegister:) forControlEvents:UIControlEventTouchUpInside];
    [skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:skipButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.titleLabel.text = @"其他方式登录";

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
    [self.actionButton setTitle:@"登录" forState:UIControlStateNormal];

    CGFloat userNoticeY = CGRectGetMaxY(self.actionButton.frame) + 10;
    CGRect userNoticeFrame = self.userNotice.frame;
    userNoticeFrame.origin.y = userNoticeY;
    self.userNotice.frame = userNoticeFrame;
}


- (void)jumpToRegister:(id)sender {
    RegisterView *registerView = [[RegisterView alloc] init];
    [self.navigationController pushViewController:registerView animated:TRUE];
}


@end
