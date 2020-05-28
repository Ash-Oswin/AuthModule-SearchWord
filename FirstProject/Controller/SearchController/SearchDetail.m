//
//  DetailViewController.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/14.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "SearchDetail.h"
#import "PhraseCell.h"
#import "WordTypeCell.h"
#import "NotesCell.h"


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
// 获取rgb
#define ssRGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]


static CGFloat phraseCellHeight = 80;
static CGFloat sectionHeight = 35;


@interface SearchDetail ()

@property (strong, nonatomic) UILabel *titleLabel;

typedef NS_ENUM(NSInteger, SectionType) {
    SectionTypeWordType = 0,
    SectionTypePhrase = 1,
    SectionTypeNotes = 2,
};

@end


@implementation SearchDetail


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat titleLabelWidth = SCREEN_WIDTH / 2;
    CGFloat titleLabelHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat titleLabelX = SCREEN_WIDTH * 0.15;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, 0,
                                                                    titleLabelWidth, titleLabelHeight)];
    self.titleLabel.font = [UIFont systemFontOfSize: 19];
    self.titleLabel.textColor = ssRGB(52, 186, 157);
    self.titleLabel.text = self.dataDict[@"spelling"];
    [self.navigationController.navigationBar addSubview: self.titleLabel];
    self.navigationItem.backBarButtonItem.style = UIBarButtonSystemItemReply;
    self.navigationController.navigationBar.tintColor = ssRGB(52, 186, 157);
    
    /* 点击转换按钮切换英美发音（未完成）*/
    self.pronunciationLabel.text = self.dataDict[@"phonetic_uk"];
    /* 根据释义个数生成动态单元格（未完成）*/
    self.interpretationsLabel.text = self.dataDict[@"interpretations"][0][@"interpretation"];
    
    self.frequencyRankLabel.text = self.dataDict[@"frequencyRank"];
    
    NSInteger difficultyLevelCountNum = [self.dataDict[@"difficulty"] intValue];
    self.difficultyLevelLabel.text = [[NSString alloc] initWithFormat:@"%ld/10", difficultyLevelCountNum];
    
    long studyUserCountNum = [self.dataDict[@"study_user_count"] longValue];
    self.studyUserCountLabel.text = [[NSString alloc] initWithFormat:@"%ld", studyUserCountNum];
    
    double acknowledgeRate = [self.dataDict[@"acknowledge_rate"] doubleValue] * 100;
    self.acknowledgeRateLabel.text = [[NSString alloc] initWithFormat:@"%.2f%%", acknowledgeRate];
    
    /* 删除多余的空行 */
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


#pragma mark --UITableViewDataSource实现


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case SectionTypePhrase: {
            return [self.dataDict[@"phrases"] count];
        }
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case SectionTypePhrase: {
            PhraseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
            if (cell == nil) {
                cell = [[PhraseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
            }
            NSInteger row = indexPath.row;
            cell.phraseLabel.text = self.dataDict[@"phrases"][row][@"phrase"];
            cell.interpretLabel.text = self.dataDict[@"phrases"][row][@"interpretation"];
            return cell;
        }
            
        case SectionTypeNotes: {
            NotesCell *notesCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (notesCell == nil) {
                notesCell = [[NotesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            }
            notesCell.label.text = self.dataDict[@"notes"][0][@"type"];
            notesCell.textView.text = self.dataDict[@"notes"][0][@"note"];
            [notesCell autoConfigTextViewHeight];
            return notesCell;
        }
            
        default:
            return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case SectionTypePhrase:
            return phraseCellHeight;
        case SectionTypeNotes: {
            CGRect re = [self.tableView rectForSection: indexPath.section];
            CGRect sect = [self.tableView convertRect:re toView:[self.tableView superview]];
            return SCREEN_HEIGHT - CGRectGetMinY(sect);
        }
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


// 设置静态单元格中动态单元格每格的indentationLevel，不设置会报错
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == SectionTypePhrase) {
        return [super tableView:tableView indentationLevelForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:SectionTypePhrase]];
    }
    
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];

}


#pragma mark --设置section样式


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
         return nil;
    }
    UIView* sectionView = [[UIView alloc] init];
    sectionView.backgroundColor = ssRGB(248, 248, 248);
    
    CGFloat labelWidth = 90;
    CGFloat labelHeight = 20;
    CGFloat labelX = SCREEN_WIDTH * 0.05;
    CGFloat labelY = (tableView.sectionHeaderHeight) / 4;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
    label.font = [UIFont systemFontOfSize: 16];
    label.backgroundColor = [UIColor clearColor];
    label.text = sectionTitle;
    [sectionView addSubview:label];
    return sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // 不显示第一个section头
    if (section == 0) {
        return 0;
    }
    return sectionHeight;
}


@end
