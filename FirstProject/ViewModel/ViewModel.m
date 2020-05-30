//
//  ViewModel.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/16.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "ViewModel.h"
#import "NetworkManager.h"


@interface ViewModel ()

@property (copy, nonatomic) NSArray <NSDictionary *> *rawData;
@property (copy, nonatomic) NSArray *dataForQuery;

@property (copy, nonatomic) NetworkManager *manager;

@end


@implementation ViewModel


#pragma mark --调用接口查询数据


- (instancetype)initWithApiData {
    self = [super init];
    if (self) {
        _manager = [[NetworkManager alloc] init];
    }
    return self;
}


- (NSArray *)getApiQueryDataWithString:(NSString *)word {
    NSArray *queryData = [self.manager searchWithWord:word];
    if (queryData == nil) {
        return nil;
    };
    return queryData;
}


#pragma mark --查找本地数据


- (instancetype)initWithLocalData {
    self = [super init];
    if (self) {
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"simple-voc-data" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
        NSArray *toBeVerified = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        _rawData = [toBeVerified isKindOfClass:[NSArray class]] ? toBeVerified : [[NSArray alloc] init];
    }
    return self;
}


#pragma mark --过滤数据


- (NSArray *)getQueryData {
    NSMutableArray *unSortArray = [[NSMutableArray alloc] init];
    if (self.rawData.count == 0) {
        return nil;
    }
    for (NSDictionary *tempDict in self.rawData) {
        NSDictionary *dict = [self getSafetySingleQueryDataWithDict:tempDict];
        [unSortArray addObject:dict];
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"spelling" ascending:TRUE];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [unSortArray sortUsingDescriptors:sortDescriptors];
    self.dataForQuery = unSortArray;
    return self.dataForQuery;
}


- (NSDictionary *)getDetailDataWith:(NSString *)selectWord {
    NSPredicate *scopePredocate = [NSPredicate predicateWithFormat:@"SELF.spelling BEGINSWITH[c] %@", selectWord];
    NSArray *toBeVerifiedArray = [self.rawData filteredArrayUsingPredicate:scopePredocate];
    NSDictionary *tempDict = ([toBeVerifiedArray isKindOfClass:[NSArray class]] && toBeVerifiedArray.count > 0) ? toBeVerifiedArray[0] : nil;
    return tempDict;
}


- (NSString *)clacWordFrequencyRankWith:(NSString *)word {
    NSPredicate *getSelectWord = [NSPredicate predicateWithFormat:@"SELF.spelling LIKE[c] %@", word];
    float wordFrequency = [[self.rawData filteredArrayUsingPredicate:getSelectWord][0][@"frequency"] floatValue];
     
    NSPredicate *frequencyGTRWord = [NSPredicate predicateWithFormat:@"SELF.frequency > %f", wordFrequency];
    NSArray *frequencyGTRWordArray = [self.rawData filteredArrayUsingPredicate:frequencyGTRWord];
    
    NSPredicate *frequencyEQUWord = [NSPredicate predicateWithFormat:@"SELF.frequency == %f", wordFrequency];
    NSMutableArray *frequencyEQUWordArray = [[self.rawData filteredArrayUsingPredicate:frequencyEQUWord] mutableCopy];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"spelling" ascending:TRUE];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [frequencyEQUWordArray sortUsingDescriptors:sortDescriptors];
    NSInteger countBeforeWord = [frequencyEQUWordArray indexOfObject:getSelectWord];
    if (countBeforeWord == -1) {
        countBeforeWord = 0;
    }
    
    NSInteger clacFrequencyRank = [frequencyGTRWordArray count] + countBeforeWord + 1;
    NSInteger dataCount = self.rawData.count;
    NSString *frequencyRank = [[NSString alloc] initWithFormat:@"%d/%d", clacFrequencyRank, dataCount];
    return frequencyRank;
}


- (NSDictionary *)getSafetySingleQueryDataWithDict:(NSDictionary *)dict {
    @try {
        NSAssert([self isNotEmptyAndisNSStringTypewithString: dict[@"spelling"]], @"invalid spelling");
        NSAssert([self isNotEmptyAndisNSStringTypewithString: dict[@"interpretations"][0][@"interpretation"]], @"invalid interpretation");
    } @catch (NSException *exception) {
        return nil;
    }
    
    NSDictionary *tempDict = @{@"spelling": dict[@"spelling"], @"interpretation": dict[@"interpretations"][0][@"interpretation"]};
    return tempDict;
}


#pragma mark --工具函数


/* 判断传入的字符串是否为空 */
- (BOOL)isNotEmptyAndisNSStringTypewithString:(NSString *)str {
    if (!str) {
        return FALSE;
    }
    if (![str isKindOfClass:[NSString class]]) {
        return FALSE;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [str stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return FALSE;
    }
    return TRUE;
}


@end
