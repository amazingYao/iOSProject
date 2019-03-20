//
//  YKUser.h
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKUser : NSObject
//从UserDefaults中获取信息 --返回字符串类型
+ (NSString*)getStringDataFromUserDefaults:(NSString*) key default:(NSString*)defaultValue;

//从UserDefaults中获取信息 --返回布尔类型
+ (BOOL)getBoolDataFromUserDefaults:(NSString*) key default:(BOOL)defaultValue;
//将字符串值设置到UserDefaults中
+ (NSString*)putStringDataToUserDefaults:(NSString*) key value:(NSString*)value;

//将布尔值设置到UserDefaults中
+ (BOOL)putBoolDataFromUserDefaults:(NSString*) key value:(BOOL)value;
@end
