//
//  UserBindCell.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/23.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "UserBindCell.h"


@implementation UserBindCell


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize: 15.0];
        [self.layer setCornerRadius: 6];
        self.layer.masksToBounds = TRUE;
        [self setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}


@end
