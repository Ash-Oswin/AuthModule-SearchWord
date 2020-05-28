//
//  RegisterViewController.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/19.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "RegisterView.h"
#import "ElseLoginView.h"
#import "SkipView.h"


@interface RegisterView ()

@end


@implementation RegisterView


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
    [skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:skipButton];
    /* 从其它方式登录视图跳转的不显示跳过按钮 */
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (![[viewControllers objectAtIndex:viewControllers.count - 2] isKindOfClass:[ElseLoginView class]]) {
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    self.titleLabel.text = @"账号注册";
    [self.forgetPassword removeFromSuperview];
    [self.accountField customPlaceholderWithString:@"请输入手机号"];
    [self.actionButton setTitle:@"注册" forState:UIControlStateNormal];
    self.bottomLabel.text = @"暂时只支持中国大陆手机注册";
}


- (void)skipAction:(id)sender {
    SkipView *skipView = [[SkipView alloc] init];
    [skipView showView];
}


@end
