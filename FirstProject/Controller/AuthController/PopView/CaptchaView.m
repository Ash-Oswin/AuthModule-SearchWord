//
//  CaptchaView.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/28.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "CaptchaView.h"
#import "UIColor+Hex.h"
#import "InputTextField.h"
#import "ClickAnimationButton.h"


@interface CaptchaView ()

@property (strong, nonatomic) UILabel *descript;
@property (strong, nonatomic) InputTextField *captchaTextField;
@property (strong, nonatomic) UIView *captchaImageView;
@property (strong, nonatomic) UIButton *actionButton;

@end


@implementation CaptchaView


- (instancetype)init {
    self = [super init];
    if (self) {
        CGFloat const LeftAndRightMargin = 15;
        CGFloat const GeneralWidth = CGRectGetWidth(self.alertView.frame) - (LeftAndRightMargin * 2);
        CGFloat const GeneralHeight = 36;
        CGFloat const GeneralX = (CGRectGetWidth(self.alertView.frame) - GeneralWidth) / 2;
        CGFloat const GeneralFontSize = 13;
        UIColor *const maimemoGary = [UIColor colorWithHexString:@"#5d5d5d"];
        
        self.titleLabel.text = @"获取验证";
        self.titleLabel.textColor = maimemoGary;
        
        CGFloat descriptTopMargin = 15;
        CGFloat descriptLineSpacing = 6;
        CGFloat descriptY = CGRectGetMaxY(self.titleLabel.bounds) + descriptTopMargin - descriptLineSpacing;
        CGFloat descriptHeight = (GeneralFontSize * 3) + (descriptLineSpacing * 5);
        _descript = [[UILabel alloc] initWithFrame:CGRectMake(GeneralX, descriptY, GeneralWidth, descriptHeight)];
        _descript.attributedText = [self attributedStringWithString:@"由于获取验证码次数过于频繁，墨墨需进行一次短暂的验证，请输入下方图案里的验证码进行验证。"
                                                               font:[UIFont systemFontOfSize:GeneralFontSize] maxWidth:GeneralWidth lineSpacing:6];
        _descript.textColor = maimemoGary;
        _descript.numberOfLines = 0;
        _descript.font = [UIFont systemFontOfSize:GeneralFontSize];
        [self.alertView addSubview:_descript];
        
        CGFloat buttonTopMargin = 12 - descriptLineSpacing;
        CGFloat captchaMargin = 10;
        CGFloat captchaImageViewWidth = 98;
        CGFloat captchaY = CGRectGetMaxY(_descript.frame) + buttonTopMargin;
        CGFloat textFieldWidth = GeneralWidth - captchaMargin - captchaImageViewWidth;
        _captchaTextField = [[InputTextField alloc] initWithFrame:CGRectMake(LeftAndRightMargin, captchaY,
                                                                             textFieldWidth, GeneralHeight)];
        _captchaTextField.textColor = maimemoGary;
        _captchaTextField.font = [UIFont systemFontOfSize:GeneralFontSize];
        [_captchaTextField customPlaceholderWithString:@"请输入验证码"
                                                  font:[UIFont systemFontOfSize:GeneralFontSize]];
        [_captchaTextField addTarget:self action:@selector(captchaTextFieldValueHasChange:)
                    forControlEvents:UIControlEventEditingChanged];
        [self.alertView addSubview:_captchaTextField];
        
        CGFloat captchaImageViewX = CGRectGetMaxX(_captchaTextField.frame) + captchaMargin;
        _captchaImageView = [[UIView alloc] initWithFrame:CGRectMake(captchaImageViewX, captchaY,
                                                                     captchaImageViewWidth, GeneralHeight)];
        _captchaImageView.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
        [self.alertView addSubview:_captchaImageView];
        
        CGFloat actionButtonTopMargin = 15;
        CGFloat actionButtonY = CGRectGetMaxY(_captchaTextField.frame) + actionButtonTopMargin;
        CGFloat actionButtonWidth = GeneralWidth;
        _actionButton = [[ClickAnimationButton alloc] init];
        _actionButton.frame = CGRectMake(GeneralX, actionButtonY,
                                       actionButtonWidth, GeneralHeight);
        [_actionButton setTitle:@"验证" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize: GeneralFontSize];
        _actionButton.enabled = FALSE;
        _actionButton.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
        [self.alertView addSubview:_actionButton];
        
        [self autoConfigAlertViewheight];
    }
    return self;
}


- (void)captchaTextFieldValueHasChange:(id)sender {
    if (_captchaTextField.text.length > 0) {
        _actionButton.enabled = TRUE;
        _actionButton.backgroundColor = [UIColor colorWithHexString:@"#36B59D"];
    } else {
        _actionButton.enabled = FALSE;
        _actionButton.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    }
}


@end
