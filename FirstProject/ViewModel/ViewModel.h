//
//  ViewModel.h
//  FirstProject
//
//  Created by 谢政 on 2020/5/16.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

- (NSArray *)getQueryData;
- (NSDictionary *)getDetailDataWith: (NSString *)selectWord;
- (NSString *)clacWordFrequencyRankWith: (NSString *)word;

@end

NS_ASSUME_NONNULL_END
            
