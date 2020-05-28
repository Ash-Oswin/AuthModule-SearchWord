//
//  InputTextField.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/19.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "InputTextField.h"
#import "UIColor+Hex.h"


@interface InputTextField ()

@property (strong, nonatomic) UIView *bottomBorder;

@end


@implementation InputTextField


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTintColor:[UIColor colorWithHexString:@"36B59D"]];
        [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        
        CGFloat bottomBorderHeight = 0.5;
        CGFloat bottomBorderWidth = CGRectGetWidth(self.frame);
        CGFloat bottomBorderX = CGRectGetMinX(self.bounds);
        CGFloat bottomBorderY = CGRectGetMaxY(self.bounds);
        self.bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(bottomBorderX, bottomBorderY, bottomBorderWidth, bottomBorderHeight)];
        self.bottomBorder.backgroundColor = [UIColor colorWithHexString:@"#cdcdcd"];
        [self addSubview: self.bottomBorder];
    }
    return self;
}


- (void)customPlaceholderWithString:(NSString *)str font:(UIFont *)font {
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString: str];
    NSRange range = [str rangeOfString: str];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#aaaaaa"] range: range];
    [placeholder addAttribute:NSFontAttributeName value:font range:range];
    self.attributedPlaceholder = placeholder;
}


- (void)customPlaceholderWithString:(NSString *)str {
    [self customPlaceholderWithString:str font:[UIFont systemFontOfSize:15.0]];
}


@end

