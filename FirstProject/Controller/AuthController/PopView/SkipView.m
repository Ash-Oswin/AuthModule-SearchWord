//
//  SkipView.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/26.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "SkipView.h"
#import "UIColor+Hex.h"
#import "SearchHome.h"


@interface SkipView ()

@property (strong, nonatomic) UILabel *descript;
@property (strong, nonatomic) UIButton *skipButton;
@property (strong, nonatomic) UIButton *cancelButton;

@end


@implementation SkipView


- (instancetype)init {
    self = [super init];
    if (self) {
        UIColor *const maimemoBrown = [UIColor colorWithHexString:@"#DC663E"];
        CGFloat const LeftAndRightMargin = 15;
        CGFloat const GeneralWidth = CGRectGetWidth(self.alertView.frame) - (LeftAndRightMargin * 2);
        CGFloat const GeneralX = (CGRectGetWidth(self.alertView.frame) - GeneralWidth) / 2;
        CGFloat const GeneralFontSize = 13;

        self.titleLabel.text = @"提示";
        self.titleLabel.textColor = maimemoBrown;
        
        CGFloat descriptTopMargin = 15;
        CGFloat descriptLineSpacing = 6;
        CGFloat descriptY = CGRectGetMaxY(self.titleLabel.bounds) + descriptTopMargin - descriptLineSpacing;
        CGFloat descriptHeight = (GeneralFontSize * 3) + (descriptLineSpacing * 5);
        _descript = [[UILabel alloc] initWithFrame:CGRectMake(GeneralX, descriptY, GeneralWidth, descriptHeight)];
        _descript.attributedText = [self attributedStringWithString:@"根据国家网络安全法要求，需要绑定手机再使用，如果点击跳过，将无法使用墨墨部分功能。"
                                                               font:[UIFont systemFontOfSize:GeneralFontSize] maxWidth:GeneralWidth lineSpacing:6];
        _descript.textColor = maimemoBrown;
        _descript.numberOfLines = 0;
        _descript.font = [UIFont systemFontOfSize:GeneralFontSize];
        [self.alertView addSubview:_descript];
        
        CGFloat buttonWidth = (GeneralWidth / 2) - 5;
        CGFloat buttonHeight = 36;
        CGFloat buttonTopMargin = 12 - descriptLineSpacing;
        CGFloat buttonY = CGRectGetMaxY(self.descript.frame) + buttonTopMargin;
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame = CGRectMake(CGRectGetMinX(self.descript.frame), buttonY,
                                       buttonWidth, buttonHeight);
        [_skipButton setTitle:@"确定跳过" forState:UIControlStateNormal];
        [_skipButton setTitleColor:maimemoBrown forState:UIControlStateNormal];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize: GeneralFontSize];
        _skipButton.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];;
        [_skipButton.layer setCornerRadius: 4];
        _skipButton.layer.masksToBounds = TRUE;
        [_skipButton addTarget:self action:@selector(skipButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:_skipButton];
        
        CGFloat cancelButtonX = CGRectGetMaxX(self.descript.frame) - buttonWidth;
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(cancelButtonX, buttonY,
                                       buttonWidth, buttonHeight);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:maimemoBrown forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize: GeneralFontSize];
        _cancelButton.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];;
        [_cancelButton.layer setCornerRadius: 4];
        _cancelButton.layer.masksToBounds = TRUE;
        [_cancelButton addTarget:self action:@selector(cancelButtonAction)
                forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:_cancelButton];
        
        [self autoConfigAlertViewheight];
    }
    return self;
}


- (void)skipButtonAction {
    [self removeFromSuperview];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *searchNav = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SearchNav"];
    [UIApplication sharedApplication].keyWindow.rootViewController = searchNav;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"animation"];
}


- (void)cancelButtonAction {
    [self removeFromSuperview];
}


@end
