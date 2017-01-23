//
//  MJExtensionConfig.m
//  DLVideo
//
//  Created by DalinXie on 17/1/22.
//  Copyright © 2017年 itdarlin. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "DLHotModel.h"
#import "DLCreator.h"
@implementation MJExtensionConfig

+ (void)load {
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    [DLCreator mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"desc" : @"description"
                 };
    }];
    //驼峰转下划线
    [DLCreator mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    [DLHotModel mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
}
@end
