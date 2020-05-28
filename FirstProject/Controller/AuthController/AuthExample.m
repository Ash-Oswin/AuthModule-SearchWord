//
//  AuthExample.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/19.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "AuthExample.h"
#import "UIColor+Hex.h"
#import "InputTextField.h"
#import "ForgetPasswordView.h"
#import "CaptchaView.h"


@interface AuthExample () <UITextFieldDelegate>

@end


@implementation AuthExample


- (void)viewDidLoad {
    CGRect const Screen = [[UIScreen mainScreen] bounds];
    CGFloat const ScreenWidth = CGRectGetWidth(Screen);
    CGFloat const ScreenHeight = CGRectGetHeight(Screen);
    CGFloat const GeneralHeight = 36;
    CGFloat const GeneralWidth = ScreenWidth > 320 ? 295 : (ScreenWidth - 30) / 2;
    CGFloat const GeneralX = (ScreenWidth - GeneralWidth) / 2;
    CGRect const NavRect = self.navigationController.navigationBar.frame;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";
    
    CGFloat titleLabelY = CGRectGetMaxY(NavRect) + 20;
    CGFloat titleLabelFontSize = 32;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GeneralX, titleLabelY,
                                                                          GeneralWidth, titleLabelFontSize)];
    self.titleLabel.text = @"Label";
    self.titleLabel.font = [UIFont systemFontOfSize: titleLabelFontSize];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#5D5D5D"];
    [self.view addSubview: self.titleLabel];
    
    CGFloat accountFieldY = CGRectGetMaxY(self.titleLabel.frame) + 15;
    self.accountField = [[InputTextField alloc] initWithFrame: CGRectMake(GeneralX, accountFieldY,
                                                                                    GeneralWidth, GeneralHeight)];
    [self.accountField customPlaceholderWithString:@"请输入手机号/邮箱"];
    self.accountField.delegate = self;
    [self.accountField addTarget:self action:@selector(accountFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
    [self.accountField addTarget:self action:@selector(actionButtonCanBeClick)
                 forControlEvents:UIControlEventEditingChanged];
    self.accountField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview: self.accountField];
    
    CGFloat captchaButtonFontSize = 14;
    CGFloat captchaButtonWidth = (captchaButtonFontSize * 5) + 20;
    CGFloat captchaTextFieldY = CGRectGetMaxY(self.accountField.frame) + 14;
    CGFloat captchaTextFieldWidth = GeneralWidth - captchaButtonWidth - 10;
    CGFloat captchaTextFieldX = CGRectGetMinX(self.accountField.frame);
    self.captchaTextField = [[InputTextField alloc] initWithFrame: CGRectMake(captchaTextFieldX, captchaTextFieldY,
                                                                                        captchaTextFieldWidth, GeneralHeight)];
    [self.captchaTextField customPlaceholderWithString:@"请输入验证码"];
    self.captchaTextField.delegate = self;
    [self.captchaTextField addTarget:self action:@selector(actionButtonCanBeClick)
                 forControlEvents:UIControlEventEditingChanged];
    self.captchaTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview: self.captchaTextField];
    
    CGFloat captchaButtonHeight = 37;
    CGFloat captchaButtonX = CGRectGetMaxX(self.captchaTextField.frame) + 10;
    CGFloat captchaButtonY = captchaTextFieldY;
    self.captchaButton = [[ClickAnimationButton alloc] init];
    self.captchaButton.frame = CGRectMake(captchaButtonX, captchaButtonY,
                                                    captchaButtonWidth, captchaButtonHeight);
    [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.captchaButton setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
    self.captchaButton.titleLabel.font = [UIFont systemFontOfSize: 14];
    [self.captchaButton.layer setBorderColor:[UIColor colorWithHexString:@"#aaaaaa"].CGColor];
    [self.captchaButton.layer setBorderWidth: 0.5];
    self.captchaButton.enabled = FALSE;
    [self.captchaButton addTarget:self action:@selector(captchaButtonAction:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.captchaButton];
    
    CGFloat passwordFieldY = CGRectGetMaxY(self.captchaButton.frame) + 14;
    self.passwordField = [[PasswordTextField alloc] initWithFrame: CGRectMake(GeneralX, passwordFieldY,
                                                                                        GeneralWidth, GeneralHeight)];
    self.passwordField.secureTextEntry = TRUE;
    self.passwordField.clearsOnBeginEditing = FALSE;
    [self.passwordField customPlaceholderWithString:@"请输入密码"];
    self.passwordField.delegate = self;
    [self.passwordField addTarget:self action:@selector(actionButtonCanBeClick)
                 forControlEvents:UIControlEventEditingChanged];
    self.passwordField.keyboardType = UIKeyboardTypeEmailAddress;
//    self.passwordField.textContentType = UITextContentTypeOneTimeCode;
    [self.view addSubview: self.passwordField];
    
    CGFloat errorTipsFontSize = 13;
    CGFloat errorTipsWidth = GeneralWidth * 0.35;
    CGFloat errorTipsX = CGRectGetMinX(self.passwordField.frame);
    CGFloat errorTipsY = passwordFieldY + GeneralHeight + 8;
    self.errorTips = [[UILabel alloc] initWithFrame: CGRectMake(errorTipsX, errorTipsY,
                                                                        errorTipsWidth, errorTipsFontSize)];
    self.errorTips.text = @"tips!";
    self.errorTips.font = [UIFont systemFontOfSize: errorTipsFontSize];
    self.errorTips.textColor = [UIColor colorWithHexString:@"#DC663E"];
    self.errorTips.hidden = TRUE;
    [self.view addSubview: self.errorTips];

    CGFloat forgetPassWordFontSize = 14;
    CGFloat forgetPassWordWidth = (forgetPassWordFontSize * 5) + 10;
    CGFloat forgetPassWordX = CGRectGetMaxX(self.passwordField.frame) - forgetPassWordWidth + 10;
    CGFloat forgetPassWordY = errorTipsY;
    self.forgetPassword = [ClickAnimationButton buttonWithType:UIButtonTypeSystem];
    self.forgetPassword.frame = CGRectMake(forgetPassWordX, forgetPassWordY,
                                                    forgetPassWordWidth, forgetPassWordFontSize);
    self.forgetPassword.titleLabel.font = [UIFont systemFontOfSize: forgetPassWordFontSize];
    [self.forgetPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetPassword setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
    [self.forgetPassword addTarget:self action:@selector(forgetPasswordAction:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.forgetPassword];
    
    CGFloat actionButtonY = CGRectGetMaxY(self.passwordField.frame) + 40;
    self.actionButton = [[ClickAnimationButton alloc] init];
    self.actionButton.frame = CGRectMake(GeneralX, actionButtonY,
                                                      GeneralWidth, GeneralHeight);
    self.actionButton.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [self.actionButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [self.actionButton setTitle:@"label" forState:UIControlStateNormal];
    self.actionButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.actionButton.enabled = FALSE;
    [self.actionButton addTarget:self action:@selector(actionButtonaction:)
                forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.actionButton];
    
    CGFloat userNoticeY = CGRectGetMaxY(self.actionButton.frame) + 10;
    CGFloat userNoticeFontSize = 13;
    self.userNotice = [[UILabel alloc] initWithFrame:CGRectMake(GeneralX, userNoticeY,
                                                                          GeneralWidth, userNoticeFontSize)];
    NSString *userNoticeStr = @"登录代表同意墨墨的服务协议、隐私政策";
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString: userNoticeStr];
    NSRange allTextRange = [[hintString string] rangeOfString: userNoticeStr];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString: @"#5D5D5D"] range:allTextRange];
    NSRange serviceRange = [userNoticeStr rangeOfString:@"服务协议"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString: @"#36B59D"] range:serviceRange];
    NSRange privacyRange = [userNoticeStr rangeOfString:@"隐私政策"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString: @"#36B59D"] range:privacyRange];
    self.userNotice.attributedText = hintString;
    self.userNotice.font = [UIFont systemFontOfSize: userNoticeFontSize];
    self.userNotice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.userNotice];

    CGFloat contactUsY = ScreenHeight - 15 - 34;
    CGFloat contactUsFontSize = 13;
    self.bottomLabel = [[UILabel alloc] initWithFrame: CGRectMake(GeneralX, contactUsY,
                                                                          GeneralWidth, contactUsFontSize)];
    self.bottomLabel.text = @"遇到问题？联系客服";
    self.bottomLabel.font = [UIFont systemFontOfSize: 15];
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.textColor = [UIColor colorWithHexString:@"#8e8e8e"];
    [self.view addSubview: self.bottomLabel];
}


#pragma mark --点击按钮执行事件


- (void)forgetPasswordAction:(id)sender {
    ForgetPasswordView *forgetPasswordView = [[ForgetPasswordView alloc] init];
    [self.navigationController pushViewController:forgetPasswordView animated:TRUE];
}


- (void)captchaButtonAction:(id)sender {
    [self.view endEditing:YES];
    CaptchaView *captchaView = [[CaptchaView alloc] init];
    [captchaView showView];
}



- (void)actionButtonaction:(id)sender {
    [self.view endEditing:YES];
}


#pragma mark --检测文本输入状态


- (void)accountFieldDidChange:(UITextField *)textField {
    if (textField.text.length > 0) {
        [self.captchaButton setTitleColor:[UIColor colorWithHexString:@"#36B59D"] forState:UIControlStateNormal];
        [self.captchaButton.layer setBorderColor:[UIColor colorWithHexString:@"#36B59D"].CGColor];
        self.captchaButton.enabled = TRUE;
    } else {
        [self.captchaButton setTitleColor:[UIColor colorWithHexString:@"#aaaaaa"] forState:UIControlStateNormal];
        [self.captchaButton.layer setBorderColor:[UIColor colorWithHexString:@"#aaaaaa"].CGColor];
        self.captchaButton.enabled = FALSE;
    }
}


#pragma mark --检测按钮是否能被点击


- (void)actionButtonCanBeClick {
    BOOL hasCaptchaTextField = [[self.view subviews] containsObject: self.captchaTextField];
    if (hasCaptchaTextField) {
        if (self.accountField.text.length > 0 && self.captchaTextField.text.length > 0 && self.passwordField.text.length > 0) {
            [self actionButtonEnable];
        } else {
            [self actionButtonDisable];
        }
    } else {
        if (self.accountField.text.length > 0 && self.passwordField.text.length > 0) {
            [self actionButtonEnable];
        } else {
            [self actionButtonDisable];
        }
    }
}

- (void)actionButtonEnable {
    self.actionButton.backgroundColor = [UIColor colorWithHexString:@"#36B59D"];
    self.actionButton.enabled = TRUE;
}

- (void)actionButtonDisable {
    self.actionButton.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    self.actionButton.enabled = FALSE;
}


#pragma mark --UITextFieldDelegate


/* 修复密码明暗文切换时会清空输入框的bug */
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
////    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
////    if (textField == self.passwordField && textField.isSecureTextEntry) {
////        textField.text = toBeString;
////        return FALSE;
////    }
////    return TRUE;
//}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.passwordField && textField.secureTextEntry) {
        [textField insertText:self.passwordField.text];
    }
}


@end
