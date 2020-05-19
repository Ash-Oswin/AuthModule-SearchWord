//
//  SearchCell.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/16.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "SearchCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

# pragma mark --自定义Cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}
@end
