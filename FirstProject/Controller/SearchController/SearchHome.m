//
//  ViewController.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/14.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "SearchHome.h"
#import "SearchDetail.h"
#import "ViewModel.h"
#import "SearchCell.h"


@interface SearchHome () <UISearchBarDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) ViewModel *viewModel;
@property (copy, nonatomic) NSArray<NSDictionary *> *dataList;
@property (copy, nonatomic) NSMutableArray<NSDictionary *> *filterDataList;

@end


@implementation SearchHome


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.viewModel = [[ViewModel alloc] init];
    self.dataList = [self.viewModel getQueryData];
    if (self.dataList == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"很抱歉，程序出现未知错误，请重启程序后再试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *exitAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction: exitAction];
        [self presentViewController:alert animated:TRUE completion:nil];
        self.searchBar.userInteractionEnabled = FALSE;
        self.tableView.scrollEnabled = FALSE;
    }
    self.filterDataList = [[NSMutableArray alloc] init];
    // 删除多余的单元格空行
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
}



#pragma mark --实现UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterDataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    NSDictionary *dict = self.filterDataList[row];
    NSString *spelling = [dict[@"spelling"] isKindOfClass:[NSString class]] ? dict[@"spelling"] : @"undefined";
    NSString *interpre = [dict[@"interpretation"] isKindOfClass:[NSString class]] ? dict[@"interpretation"] : @"undefined";
    cell.spellingLabel.text = spelling;
    cell.interpreLabel.text = interpre;
    return cell;
}


#pragma mark --实现UITableViewDataSource


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}


#pragma mark --实现UISearchBarDelegate


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterContentForSearchText: searchText];
    [self.tableView reloadData];
}


#pragma mark --实现UISearchResultsUpdating


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.tableView reloadData];
}


#pragma mark --数据查找函数


- (void)filterContentForSearchText:(NSString *)searchText {
    // 如果搜索栏为空则清除查找后的数据
    if ([searchText length] == 0) {
        self.filterDataList = nil;
    }
    // 以输入的字符为首，后面匹配任意个字符串
    NSPredicate *scopePredocate = [NSPredicate predicateWithFormat:@"SELF.spelling BEGINSWITH[c] %@", searchText];
    NSArray *tempArray = [self.dataList filteredArrayUsingPredicate: scopePredocate];
    self.filterDataList = [NSMutableArray arrayWithArray: tempArray];
}


#pragma mark --实现页面跳转时触发函数


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        SearchDetail *detail = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger selectedIndex = indexPath.row;
        NSString *selectWord = self.filterDataList[selectedIndex][@"spelling"];
        if ([selectWord isEqualToString:@"undefined"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"程序出现未知错误，单词详情丢失，请联系客服或稍后再试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *exitAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDestructive handler:nil];
            [alert addAction: exitAction];
            [self presentViewController:alert animated:TRUE completion:nil];
            return;
        }
        [self.viewModel clacWordFrequencyRankWith:selectWord];
        
        NSMutableDictionary *tempDict = [[self.viewModel getDetailDataWith:selectWord] mutableCopy];
        [tempDict setValue: [self.viewModel clacWordFrequencyRankWith: selectWord]
                    forKey: @"frequencyRank"];
        detail.dataDict = [tempDict copy];
    }
}


-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return FALSE;//开始不允许跳转，只有当验证账号和密码正确可以进入后由登录代码执行切换
}


@end
