//
//  ViewController.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/14.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "ViewModel.h"
#import "SearchCell.h"

@interface ViewController ()<UISearchBarDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSMutableArray *filterDataList;
@property (strong, nonatomic) ViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[ViewModel alloc] init];
    self.dataList = [self.viewModel getQueryData];
    
    self.title = @"";
    self.filterDataList = [[NSMutableArray alloc] init];
        
    // 删除多余的单元格空行
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
}


#pragma mark --实现UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterDataList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CellIdentifier" forIndexPath: indexPath];
    
    NSInteger row = [indexPath row];
    NSDictionary *dict = self.filterDataList[row];
    
    cell.spellingLabel.text = dict[@"spelling"];
    cell.interpreLabel.text = dict[@"interpretation"];
    
    return cell;
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
    if ([segue.identifier isEqualToString: @"showDetail"]) {
        DetailViewController *detail = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger selectedIndex = indexPath.row;
        NSString *selectWord = self.filterDataList[selectedIndex][@"spelling"];
        [self.viewModel clacWordFrequencyRankWith:selectWord];
        
        NSMutableDictionary *tempDict = [[self.viewModel getDetailDataWith:selectWord] mutableCopy];
        
        [tempDict setValue: [self.viewModel clacWordFrequencyRankWith: selectWord]
                    forKey: @"frequencyRank"];
        
        detail.dataDict = [tempDict copy];
    }
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

@end
