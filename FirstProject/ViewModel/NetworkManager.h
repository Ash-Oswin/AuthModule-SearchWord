//
//  NetworkManager.h
//  FirstProject
//
//  Created by 谢政 on 2020/5/29.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

- (AFHTTPSessionManager *)manager;
- (NSArray *)searchWithWord:(NSString *)word;

@end

NS_ASSUME_NONNULL_END
