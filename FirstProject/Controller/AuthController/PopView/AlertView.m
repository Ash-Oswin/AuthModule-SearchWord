//
//  AlertView.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/27.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "AlertView.h"
#import "UIColor+Hex.h"


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@interface AlertView ()

@end


static CGFloat const AlertWidth = 256;


@implementation AlertView


- (instancetype)init {
    self = [super init];
    if (self) {
        CGRect const Screen = [[UIScreen mainScreen] bounds];
        CGFloat const ScreenWidth = CGRectGetWidth(Screen);
        CGFloat const ScreenHeight = CGRectGetHeight(Screen);
        self.frame = Screen;
        
        _alertView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - AlertWidth) / 2, (ScreenWidth * 0.2), AlertWidth, ScreenHeight)];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 6;
        _alertView.layer.masksToBounds = YES;
        [self addSubview:_alertView];
        
        CGFloat titleHeight = 44;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_alertView.bounds), titleHeight)];
        _titleLabel.text = @"title";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#5d5d5d"];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat titleBottomLineheight = 0.5;
        UIView *titleBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.bounds),
                                                                           CGRectGetWidth(_titleLabel.frame), titleBottomLineheight)];
        titleBottomLine.backgroundColor = [UIColor colorWithHexString:@"#aaaaaa"];
        [_titleLabel addSubview:titleBottomLine];
        [_alertView addSubview:_titleLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handletapPressInAlertViewGesture:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


//- (CGFloat)getDescriptHeightWithString:(NSString *)string font:(UIFont *)font {
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.lineBreakMode = NSLineBreakByWordWrapping;
//    NSDictionary * attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
//    CGFloat contentHeight = [string boundingRectWithSize:CGSizeMake(AlertWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size.height;
//    return contentHeight;
//}


- (void)autoConfigAlertViewheight {
    CGFloat alertHeight = CGRectGetMaxY([[_alertView subviews] lastObject].frame);
    CGRect frame = _alertView.frame;
    /* 设置底部间距 */
    alertHeight += 15;
    CGFloat alertY = (SCREEN_HEIGHT - alertHeight) * 0.3;
    frame.size.height = alertHeight;
    frame.origin.y = alertY;
    
    _alertView.frame = frame;
}


/* 设置行间距 */
- (NSMutableAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat) maxWidth lineSpacing:(CGFloat)spacing {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    CGFloat contentHeight = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size.height;
    if (contentHeight > font.lineHeight){
        style.lineSpacing = spacing;
    } else {
        //单行的时候去掉行间距
        style.lineSpacing = 0;
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    return [attributedString mutableCopy];
}


/* 点击alertView以外的视图关闭alertView */
- (void)handletapPressInAlertViewGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [sender locationInView:_alertView];
        if (![_alertView pointInside:[_alertView convertPoint:location toView:_alertView.window] withEvent:nil]) {
            [_alertView removeGestureRecognizer:sender];
            [self removeFromSuperview];
        }
    }
}


/* 定义出现时的动画效果 */
- (void)showView {
    self.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:nil];
}


@end
