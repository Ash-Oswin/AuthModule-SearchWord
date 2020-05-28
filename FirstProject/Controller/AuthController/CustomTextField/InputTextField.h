//
//  InputTextField.h
//  FirstProject
//
//  Created by 谢政 on 2020/5/19.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface InputTextField : UITextField

- (void)customPlaceholderWithString:(NSString *)str;
- (void)customPlaceholderWithString:(NSString *)str font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
