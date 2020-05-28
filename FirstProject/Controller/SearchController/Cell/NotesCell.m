//
//  NotesCell.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/15.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "NotesCell.h"


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define ssRGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]


@interface NotesCell()

@end


@implementation NotesCell


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


# pragma mark --自定义Cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat labelWidth = 35;
        CGFloat labelHeight = 20;
        CGFloat labelX = SCREEN_WIDTH * 0.05;
        CGFloat labelY = CGRectGetMinY(self.bounds) + 15;
        self.label = [[UILabel alloc] initWithFrame: CGRectMake(labelX, labelY, labelWidth, labelHeight)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize: 12.0];
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = ssRGB(52, 186, 157);
        self.label.layer.cornerRadius = 4;
        self.label.layer.masksToBounds = YES;
        [self addSubview: self.label];

        CGFloat textViewWidth = SCREEN_WIDTH * 0.9;
        CGFloat textViewX = SCREEN_WIDTH * 0.05;
        CGFloat textViewY = labelY + labelHeight + 5;
        CGFloat textViewHeight = SCREEN_HEIGHT * 0.05;
        self.textView = [[UITextView alloc] initWithFrame: CGRectMake(textViewX, textViewY, textViewWidth, textViewHeight)];
        self.textView.font = [UIFont systemFontOfSize: 16.0];
        self.textView.editable = FALSE;
        self.textView.selectable = FALSE;
        [self addSubview: self.textView];
    }
    return self;
}
    

- (void)autoConfigTextViewHeight {
    CGRect frame = self.textView.frame;
    frame.size = CGSizeMake(self.textView.frame.size.width, self.contentView.frame.size.height);
    self.textView.frame = frame;
}


@end
