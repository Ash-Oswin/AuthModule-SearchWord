//
//  AuthExample.h
//  FirstProject
//
//  Created by 谢政 on 2020/5/19.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputTextField.h"
#import "PasswordTextField.h"
#import "ClickAnimationButton.h"


NS_ASSUME_NONNULL_BEGIN

@interface AuthExample : UIViewController

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) InputTextField *accountField;
@property (strong, nonatomic) InputTextField *captchaTextField;
@property (strong, nonatomic) ClickAnimationButton *captchaButton;
@property (strong, nonatomic) PasswordTextField *passwordField;
@property (strong, nonatomic) UILabel *errorTips;
@property (strong, nonatomic) ClickAnimationButton *forgetPassword;
@property (strong, nonatomic) ClickAnimationButton *actionButton;
@property (strong, nonatomic) UILabel *userNotice;
@property (strong, nonatomic) UILabel *bottomLabel;

@end

NS_ASSUME_NONNULL_END
