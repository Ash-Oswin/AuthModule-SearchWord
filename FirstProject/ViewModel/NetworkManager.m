//
//  NetworkManager.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/29.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "NetworkManager.h"
#import "HMFJSONResponseSerializerWithData.h"

@interface NetworkManager ()

@end

@implementation NetworkManager

- (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.operationQueue.maxConcurrentOperationCount = 5;
    manager.requestSerializer.timeoutInterval = 30.0f;
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/json", @"text/event-stream", nil];
    return manager;
}

//- (void)emailRegisterWithEmail:(NSString *)email password:(NSString *)password {
//    NSString *urlString = @"https://beta.maimemo.com:81/api/v1/user/register";
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSDictionary *prameters = @{@"email": email
//                                @"password": password
//                                @"": @
//    };
//
//    AFHTTPSessionManager *manager = [self manager];
//    [manager.requestSerializer setValue:@"false"
//                     forHTTPHeaderField:@"Ignorable"];
//    [manager.requestSerializer setValue:@"58e6bbf35da36b183d6381a9d414f028"
//                     forHTTPHeaderField:@"Signature-Salt"];
//    [manager.requestSerializer setValue:@"3d9b7b5392f704f318d020da13c9653b966ef0ab"
//                     forHTTPHeaderField:@"Signature"];
//    [manager.requestSerializer setValue:@"1"
//                     forHTTPHeaderField:@"X-Skip-Signature"];
//    [manager.requestSerializer setValue:@"en;q=1"
//                     forHTTPHeaderField:@"Accept-Language"];
//    manager.responseSerializer = [HMFJSONResponseSerializerWithData serializer];
//
//    [manager POST:<#(nonnull NSString *)#> parameters:<#(nullable id)#> progress:<#^(NSProgress * _Nonnull uploadProgress)uploadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>];
//}

- (void)emailLogin {
    
}

- (NSArray *)searchWithWord:(NSString *)word completion:(void (^)(NSArray *results, NSError *error))comlection {
    
    NSAssert(comlection, @"completion handler cannot be nil");
    
    if (!word || ![word isKindOfClass:NSString.class] || word.length == 0) {
        if (comlection) {
            NSError *error = [NSError errorWithDomain:@"com.demo.network"
                                                 code:1001
                                             userInfo:@{NSLocalizedDescriptionKey : @"invalid query parameter"}];
            comlection(nil, error);
        }
    }
    
    NSString *urlString = @"https://beta.maimemo.com:81/api/v3/vocabulary/query";
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *prameters = @{@"spelling": word};
    
    NSArray __block *queryData = nil;
    
    AFHTTPSessionManager *manager = [self manager];
    [manager.requestSerializer setValue:@"ingnorable" forHTTPHeaderField:@"false"];
    [manager POST:url.absoluteString parameters:prameters progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSString *rawData = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (rawData == nil) {
            return;
        }
        NSArray *separationArray = [rawData componentsSeparatedByString:@"\r\n"];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        NSError *error = nil;
        for (NSString *lineData in separationArray) {
            if (![self isNotEmptyAndisNSStringTypewithString:lineData]) {
                continue;
            }
            NSData *jsonData = [lineData dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                continue;
            }
            [tempArray addObject:jsonDict];
        }
        queryData = [tempArray copy];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        queryData = nil;
    }];
    
//    [manager setTaskDidCompleteBlock:^(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSError * _Nullable error) {
//
//    }];
    return queryData;
}



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
