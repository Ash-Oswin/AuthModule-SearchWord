//
//  LoginHomeViewController.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/20.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "LoginHomeView.h"
#import "UIColor+Hex.h"
#import "CustomButton/ClickAnimationButton.h"
#import "UserBindView.h"
#import "ElseLoginView.h"


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


@interface LoginHomeView ()

@property (strong, nonatomic) UIImageView *maimemoLogo;
@property (strong, nonatomic) UILabel *appName;
@property (strong, nonatomic) UILabel *firstSloganLabel;
@property (strong, nonatomic) UILabel *secondSloganlabel;
@property (strong, nonatomic) ClickAnimationButton *weChatLogin;
@property (strong, nonatomic) UILabel *userNotice;
@property (strong, nonatomic) UIView *bottomLoginColumn;
@property (strong, nonatomic) ClickAnimationButton *elseLogin;
@property (strong, nonatomic) ClickAnimationButton *appidLogin;

@end


static const CGFloat GeneralHeight = 36;


@implementation LoginHomeView


#pragma mark --lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *const MaimemoGreen = [UIColor colorWithHexString:@"#36B59D"];
    UIColor *const MaimemoDarkGary = [UIColor colorWithHexString:@"#5D5D5D"];
    UIColor *const MaimemoLightGary = [UIColor colorWithHexString:@"#8E8E8E"];
    CGFloat const GeneralWidth = SCREEN_WIDTH * 0.75;
    CGFloat const GeneralX = (SCREEN_WIDTH - GeneralWidth) / 2;

    self.navigationController.navigationBar.tintColor = MaimemoGreen;
    self.navigationController.navigationBar.topItem.title = @"";
    
    CGFloat weCharLoginY = CGRectGetMidY([[UIScreen mainScreen] bounds]);
    self.weChatLogin = [[ClickAnimationButton alloc] init];
    self.weChatLogin.frame = CGRectMake(GeneralX, weCharLoginY,
                                        GeneralWidth, GeneralHeight);
    [self.weChatLogin setTitle:@"微信登录" forState:UIControlStateNormal];
    [self.weChatLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.weChatLogin.titleLabel.font = [UIFont systemFontOfSize:15];
    self.weChatLogin.backgroundColor = MaimemoGreen;
    [self.weChatLogin addTarget:self action:@selector(jumpToUserBind:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.weChatLogin];
    
    CGFloat secondSloganlabelHeight = 14;
    CGFloat secondSloganlabelY = weCharLoginY - 36;
    self.secondSloganlabel = [[UILabel alloc] initWithFrame:CGRectMake(GeneralX, secondSloganlabelY,
                                                                       GeneralWidth, secondSloganlabelHeight)];
    self.secondSloganlabel.text = @"精准规划海量词汇记忆";
    self.secondSloganlabel.textAlignment = NSTextAlignmentCenter;
    self.secondSloganlabel.textColor = MaimemoLightGary;
    self.secondSloganlabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:self.secondSloganlabel];
    
    CGFloat firstSloganlabelFontSize = 16;
    CGFloat firstSloganlabelY = secondSloganlabelY - firstSloganlabelFontSize - 8;
    self.firstSloganLabel = [[UILabel alloc] initWithFrame:CGRectMake(GeneralX, firstSloganlabelY,
                                                                      GeneralWidth, firstSloganlabelFontSize)];
    self.firstSloganLabel.text = @"高效抗遗忘";
    self.firstSloganLabel.textAlignment = NSTextAlignmentCenter;
    self.firstSloganLabel.textColor = MaimemoLightGary;
    self.firstSloganLabel.font = [UIFont systemFontOfSize:firstSloganlabelFontSize];
    [self.view addSubview:self.firstSloganLabel];

    CGFloat firstSloganTextWidth = [self getStringWidthWithFont:self.firstSloganLabel.font String:self.firstSloganLabel.text];
    CGSize lineSize = CGSizeMake(32, 1);
    CGFloat lineY = CGRectGetMidY(self.firstSloganLabel.bounds);
    CGFloat firstSloganLeftLineX = (CGRectGetWidth(self.firstSloganLabel.bounds) - firstSloganTextWidth) / 2 - lineSize.width - 5;
    UIView *firstSloganLeftLine = [[UIView alloc] initWithFrame:CGRectMake(firstSloganLeftLineX, lineY, lineSize.width, lineSize.height)];
    firstSloganLeftLine.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [self.firstSloganLabel addSubview: firstSloganLeftLine];
    CGFloat firstSloganRightLineX = (firstSloganLeftLineX + firstSloganTextWidth + lineSize.width + 10);
    UIView *firstSloganRightLine = [[UIView alloc] initWithFrame:CGRectMake(firstSloganRightLineX, lineY, lineSize.width, lineSize.height)];
    firstSloganRightLine.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [self.firstSloganLabel addSubview:firstSloganRightLine];
    
    CGFloat appNameFontSize = 22;
    CGFloat appNameY = firstSloganlabelY - appNameFontSize - 16;
    self.appName = [[UILabel alloc] initWithFrame: CGRectMake(GeneralX, appNameY, GeneralWidth, appNameFontSize)];
    self.appName.text = @"墨墨背单词";
    self.appName.textAlignment = NSTextAlignmentCenter;
    self.appName.textColor = MaimemoDarkGary;
    self.appName.font = [UIFont systemFontOfSize:appNameFontSize];
    [self.view addSubview:self.appName];
    
    CGFloat userNoticeY = CGRectGetMaxY(self.weChatLogin.frame) + 12;
    CGFloat userNoticeFontSize = 13;
    NSString *userNoticeStr = @"登录代表同意墨墨的服务协议、隐私政策";
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:userNoticeStr];
    NSRange allTextRange = [[hintString string] rangeOfString:userNoticeStr];
    [hintString addAttribute:NSForegroundColorAttributeName value:MaimemoDarkGary range:allTextRange];
    NSRange serviceRange = [userNoticeStr rangeOfString:@"服务协议"];
    [hintString addAttribute:NSForegroundColorAttributeName value:MaimemoGreen range:serviceRange];
    NSRange privacyRange = [userNoticeStr rangeOfString:@"隐私政策"];
    [hintString addAttribute:NSForegroundColorAttributeName value:MaimemoGreen range:privacyRange];
    self.userNotice = [[UILabel alloc] initWithFrame: CGRectMake(GeneralX, userNoticeY, GeneralWidth, userNoticeFontSize)];
    self.userNotice.attributedText = hintString;
    self.userNotice.font = [UIFont systemFontOfSize:userNoticeFontSize];
    self.userNotice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.userNotice];
    
    CGFloat bottomLoginColumnY = SCREEN_HEIGHT - 34 - 44;
    self.bottomLoginColumn = [[UIView alloc] initWithFrame:CGRectMake(GeneralX, bottomLoginColumnY,
                                                                    GeneralWidth, GeneralHeight)];
    [self.view addSubview:self.bottomLoginColumn];
    CGFloat const ParentInterval = 5;
    CGRect bottomLoginColumnBounds = self.bottomLoginColumn.bounds;
    CGFloat buttonWidth = (CGRectGetWidth(bottomLoginColumnBounds) / 2) - ParentInterval;
    CGFloat buttonFontSize = 15.0;
    
    self.elseLogin = [[ClickAnimationButton alloc] init];
    self.elseLogin.frame = CGRectMake(CGRectGetMinX(bottomLoginColumnBounds), 0, buttonWidth, GeneralHeight);
    [self.elseLogin setTitle:@"其他方式登录" forState:UIControlStateNormal];
    self.elseLogin.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
    [self.elseLogin setTitleColor:MaimemoGreen forState:UIControlStateNormal];
    [self.elseLogin.layer setBorderColor:MaimemoGreen.CGColor];
    [self.elseLogin.layer setBorderWidth:0.5];
    [self.elseLogin addTarget:self action:@selector(jumpToElseLogin:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.bottomLoginColumn addSubview:self.elseLogin];
    
    CGFloat appidLoginX = CGRectGetMaxX(bottomLoginColumnBounds) - buttonWidth;
    self.appidLogin = [[ClickAnimationButton alloc] init];
    self.appidLogin.frame = CGRectMake(appidLoginX, 0, buttonWidth, GeneralHeight);
    [self.appidLogin setTitle:@"通过 Apple 登录" forState:UIControlStateNormal];
    self.appidLogin.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
    [self.appidLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.appidLogin.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.appidLogin.layer setBorderWidth:0.5];
    [self.bottomLoginColumn addSubview:self.appidLogin];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect frame = self.bottomLoginColumn.frame;
    NSLog(@"%f", self.view.safeAreaInsets.bottom);
    CGFloat bottomLoginColumnY = (self.view.safeAreaInsets.bottom != 0) ? (SCREEN_HEIGHT - self.view.safeAreaInsets.bottom - 44) : CGRectGetMinY(self.bottomLoginColumn.frame);
    frame.origin.y = bottomLoginColumnY;
    self.bottomLoginColumn.frame = frame;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* 设置导航栏颜色 */
    [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = UIImage.new;
}


#pragma mark --获取字符串宽度


- (CGFloat)getStringWidthWithFont:(UIFont *)font String:(NSString *)string{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, font.pointSize);
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width;
}


#pragma mark --点击微信登录跳转到用户绑定


- (void)jumpToUserBind:(id)sender {
    UserBindView *bindView = [[UserBindView alloc] init];
    [self.navigationController pushViewController:bindView animated:TRUE];
}


#pragma mark --跳转到其他登录


- (void)jumpToElseLogin:(id)sender {
    ElseLoginView *elseLogin = [[ElseLoginView alloc] init];
    [self.navigationController pushViewController:elseLogin animated:TRUE];
}


@end
