//
//  DetailViewController.h
//  FirstProject
//
//  Created by 谢政 on 2020/5/14.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *pronunciationLabel;

@property (weak, nonatomic) IBOutlet UILabel *interpretationsLabel;

@property (weak, nonatomic) IBOutlet UILabel *frequencyRankLabel;

@property (weak, nonatomic) IBOutlet UILabel *difficultyLevelLabel;

@property (weak, nonatomic) IBOutlet UILabel *studyUserCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *acknowledgeRateLabel;


@property (strong, nonatomic) NSDictionary *dataDict;

@end

NS_ASSUME_NONNULL_END
