//
//  HMFJSONResponseSerializerWithData.h
//  FirstProject
//
//  Created by 谢政 on 2020/5/29.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "AFURLResponseSerialization.h"
 

NS_ASSUME_NONNULL_BEGIN

/// NSError userInfo keys that will contain response data
static NSString * const JSONResponseSerializerWithDataKey = @"body";
static NSString * const JSONResponseSerializerWithBodyKey = @"statusCode";


@interface HMFJSONResponseSerializerWithData : AFJSONResponseSerializer

@end


NS_ASSUME_NONNULL_END
