//
//  ForgetPasswordView.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/26.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "ForgetPasswordView.h"


@interface ForgetPasswordView ()

@end


@implementation ForgetPasswordView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"忘记密码";
    [self.forgetPassword removeFromSuperview];
    [self.passwordField customPlaceholderWithString: @"请输入新密码"];
    [self.actionButton setTitle:@"修改" forState:UIControlStateNormal];
}


@end
