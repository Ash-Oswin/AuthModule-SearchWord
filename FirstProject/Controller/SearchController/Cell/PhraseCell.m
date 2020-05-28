//
//  PhraseCell.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/15.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "PhraseCell.h"


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)


@interface PhraseCell ()

@end


@implementation PhraseCell


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setFrame:(CGRect)frame {
    frame.origin.y += 5;
    frame.size.height += 12;
    [super setFrame:frame];
}


# pragma mark --定义例句cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellHeight = self.frame.size.height;
        CGFloat cellY = self.frame.origin.y;
        
        CGFloat phraseLabelHeight = cellHeight / 2;
        CGFloat phraseLabelWidth = SCREEN_WIDTH - 45;
        CGFloat phraseLabelX = SCREEN_WIDTH * 0.05;
        CGFloat phraseLabelY = cellY;
        self.phraseLabel = [[UILabel alloc] initWithFrame: CGRectMake(phraseLabelX, phraseLabelY,
                                                                      phraseLabelWidth, phraseLabelHeight)];
        [self addSubview: self.phraseLabel];

        CGFloat interpretLabelHeight = cellHeight / 2;
        CGFloat interpretLabelWidth = SCREEN_WIDTH - 45;
        CGFloat interpretLabelX = (SCREEN_WIDTH - interpretLabelWidth) / 2;
        CGFloat interpretLabelY = cellY + phraseLabelHeight;
        self.interpretLabel = [[UILabel alloc] initWithFrame: CGRectMake(interpretLabelX, interpretLabelY,
                                                                         interpretLabelWidth, interpretLabelHeight)];
        [self addSubview: self.interpretLabel];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}


@end
