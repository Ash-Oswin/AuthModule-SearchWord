//
//  UserBindView.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/22.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "UserBindView.h"
#import "UIColor+Hex.h"
#import "UserBindCell.h"
#import "RegisterCell.h"
#import "RegisterView.h"
#import "BindAccoutView.h"


@interface UserBindView () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITableView *tableView;

@end


static NSInteger registerRow = 0;


@implementation UserBindView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"用户绑定";
    
    CGRect const screen = [[UIScreen mainScreen] bounds];
    CGFloat const ScreenWidth = CGRectGetWidth(screen);
    CGFloat const GeneralWidth = ScreenWidth > 320 ? 295 : (ScreenWidth - 30) / 2;
    CGFloat const GeneralX = (ScreenWidth - GeneralWidth) / 2;

    CGFloat titleY = 88 + CGRectGetHeight(self.navigationController.navigationBar.frame);
    CGFloat titleFontSize = 32;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GeneralX, titleY, GeneralWidth, titleFontSize)];
    self.titleLabel.text = @"Hello";
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#5D5D5D"];
    self.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    [self.view addSubview: self.titleLabel];
    
    CGFloat cellHeight = 44;
    CGFloat tableViewY = CGRectGetMaxY(self.titleLabel.frame) + 24;
    CGFloat tableViewHeight = (cellHeight * 2) + 15;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(GeneralX, tableViewY, GeneralWidth, tableViewHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: self.tableView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"用户绑定";
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


#pragma mark --实现UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if (row == registerRow) {
        UserBindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UserBindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        NSString *registerStr = @"新用户，立即注册";
        cell.textLabel.text = registerStr;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithHexString:@"#36B59D"];
        return cell;
    } else {
        RegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[RegisterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        NSString *userBindStr = @"老用户，去绑定已有账号";
        cell.textLabel.text = userBindStr;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#36B59D"];
        cell.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        return cell;
    }
}


#pragma mark --实现UITableViewDelegate


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == registerRow) {
        RegisterView *registerView = [[RegisterView alloc] init];
        [self.navigationController pushViewController:registerView animated:TRUE];
    } else {
        BindAccoutView *bindAccoutView = [[BindAccoutView alloc] init];
        [self.navigationController pushViewController:bindAccoutView animated:TRUE];
    }
}


@end
