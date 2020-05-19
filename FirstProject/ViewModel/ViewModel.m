//
//  ViewModel.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/16.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "ViewModel.h"

@interface ViewModel ()

@property (strong, nonatomic) NSArray *dataList;

@property (strong, nonatomic) NSArray *rawData;
@property (strong, nonatomic) NSArray *dataForQuery;

@end


@implementation ViewModel
- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"simple-voc-data" ofType:@"json"];
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
        
        self.rawData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    
    return self;
}

- (NSArray *)getQueryData{
    NSMutableArray *unSortArray = [[NSMutableArray alloc] init];

    for (NSMutableDictionary *tempDict in self.rawData) {
        if (tempDict[@"spelling"] == nil ||
                     tempDict[@"interpretations"][0][@"interpretation"] == nil) {
            continue;
        }

        NSDictionary *dict = @{@"spelling" : tempDict[@"spelling"],
                               @"interpretation" : tempDict[@"interpretations"][0][@"interpretation"]};

        [unSortArray addObject: dict];
    }

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"spelling" ascending:TRUE];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [unSortArray sortUsingDescriptors:sortDescriptors];
    self.dataForQuery = unSortArray;
    
    return self.dataForQuery;
}

- (NSDictionary *)getDetailDataWith : (NSString *)selectWord {
    NSPredicate *scopePredocate = [NSPredicate predicateWithFormat:@"SELF.spelling BEGINSWITH[c] %@", selectWord];
    NSArray *tempArray = [self.rawData filteredArrayUsingPredicate: scopePredocate];
    
    return tempArray[0];
}


- (NSString *) clacWordFrequencyRankWith: (NSString *)word{
    NSPredicate *getSelectWord = [NSPredicate predicateWithFormat:@"SELF.spelling LIKE[c] %@", word];
    float wordFrequency = [[self.rawData filteredArrayUsingPredicate: getSelectWord][0][@"frequency"] floatValue];
     
    NSPredicate *frequencyGTRWord = [NSPredicate predicateWithFormat:@"SELF.frequency > %f", wordFrequency];
    NSArray *frequencyGTRWordArray = [self.rawData filteredArrayUsingPredicate:frequencyGTRWord];
    
    NSPredicate *frequencyEQUWord = [NSPredicate predicateWithFormat:@"SELF.frequency == %f", wordFrequency];
    NSMutableArray *frequencyEQUWordArray = [[self.rawData filteredArrayUsingPredicate:frequencyEQUWord] mutableCopy];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"spelling" ascending:TRUE];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [frequencyEQUWordArray sortUsingDescriptors:sortDescriptors];
    
    NSInteger countBeforeWord = [frequencyEQUWordArray indexOfObject: getSelectWord];
    if (countBeforeWord == -1) {
        countBeforeWord = 0;
    }
    
    NSInteger clacFrequencyRank = [frequencyGTRWordArray count] + countBeforeWord + 1;
    NSInteger dataCount = self.rawData.count;
    NSString *frequencyRank = [[NSString alloc] initWithFormat: @"%d/%d", clacFrequencyRank, dataCount];
    
    return frequencyRank;
}
@end
