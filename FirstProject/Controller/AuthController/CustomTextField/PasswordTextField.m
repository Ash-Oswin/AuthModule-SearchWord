//
//  PasswordTextField.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/19.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "PasswordTextField.h"
#import "UIColor+Hex.h"


@interface PasswordTextField ()

@property (strong, nonatomic) UIImageView *visibleView;

@end


@implementation PasswordTextField


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *unVisible = [UIImage systemImageNamed:@"eye.slash"];
        self.visibleView = [[UIImageView alloc] initWithImage:unVisible];
        CGRect frame = self.visibleView.frame;
        CGSize size = CGSizeMake(40, 36);
        frame.size = size;
        self.visibleView.frame = frame;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [self.visibleView addGestureRecognizer: tapGesture];
        self.visibleView.userInteractionEnabled = YES;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = self.visibleView;
        self.rightView.tintColor = [UIColor colorWithHexString:@"#aaaaaa"];
    }
    return self;
}


- (void)clickImage:(id)sender {
    self.secureTextEntry = !self.isSecureTextEntry;
    UIImage *visible = [UIImage systemImageNamed:@"eye"];
    UIImage *unVisible = [UIImage systemImageNamed:@"eye.slash"];
    self.visibleView.image = self.isSecureTextEntry ? visible : unVisible;
    
    /* 修复密码明暗文切换的bug */
    NSString *text = self.text;
    self.text = @"";
    self.text = text;
    if (self.secureTextEntry)
    {
        [self insertText:self.text];
    }
}


@end
