//
//  Example
//  man
//
//  Created by man on 11/11/2018.
//  Copyright © 2018 man. All rights reserved.
//

#import "HttpDatasource.h"
#import "NetworkHelper.h"

@implementation HttpDatasource

+ (instancetype)shared
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.httpModels = [NSMutableArray arrayWithCapacity:[[NetworkHelper shared] logMaxCount]];
    }
    return self;
}

- (BOOL)addHttpRequset:(HttpModel*)model
{
    //url过滤, 忽略大小写
    for (NSString *urlString in [[NetworkHelper shared] ignoredURLs]) {
        if ([[model.url.absoluteString lowercaseString] containsString:[urlString lowercaseString]]) {
            return NO;
        }
    }
    
    //最大个数限制
    if (self.httpModels.count >= [[NetworkHelper shared] logMaxCount]) {
        if ([self.httpModels count] > 0) {
            [self.httpModels removeObjectAtIndex:0];
        }
    }
    
    //判断重复
    __block BOOL isExist = NO;
    [self.httpModels enumerateObjectsUsingBlock:^(HttpModel *obj, NSUInteger index, BOOL *stop) {
        if ([obj.requestId isEqualToString:model.requestId]) {//数组中已经存在该对象
            isExist = YES;
        }
    }];
    if (!isExist) {//如果不存在就添加进去
        [self.httpModels addObject:model];
    }else{
        return NO;
    }
    
    return YES;
}

- (void)reset
{
    [self.httpModels removeAllObjects];
}

- (void)remove:(HttpModel *)model
{
    [self.httpModels enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(HttpModel *obj, NSUInteger index, BOOL *stop) {
        if ([obj.requestId isEqualToString:model.requestId]) {
            [self.httpModels removeObjectAtIndex:index];
        }
    }];
}

@end
