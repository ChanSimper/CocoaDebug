//
//  Example
//  man
//
//  Created by man on 11/11/2018.
//  Copyright © 2018 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCLogModel : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *fileInfo;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) BOOL isTag;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSAttributedString *attr;

- (instancetype)initWithContent:(NSString *)content color:(UIColor *)color fileInfo:(NSString *)fileInfo isTag:(BOOL)isTag;

@end
