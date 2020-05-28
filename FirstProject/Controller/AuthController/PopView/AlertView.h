//
//  AlertView.h
//  FirstProject
//
//  Created by 谢政 on 2020/5/27.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIView

@property (strong, nonatomic) UIView *alertView;
@property (strong, nonatomic) UILabel *titleLabel;

- (void)showView;
- (void)autoConfigAlertViewheight;
- (NSMutableAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat) maxWidth lineSpacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
