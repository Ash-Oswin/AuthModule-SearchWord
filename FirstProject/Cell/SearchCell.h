//
//  SearchCell.h
//  FirstProject
//
//  Created by 谢政 on 2020/5/16.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *spellingLabel;
@property (weak, nonatomic) IBOutlet UILabel *interpreLabel;

//@property (strong, nonatomic) UILabel *spellingLabel;
//@property (strong, nonatomic) UILabel *interpreLabel;

@end

NS_ASSUME_NONNULL_END
