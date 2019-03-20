//
//  YKUser.m
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "YKUser.h"

@implementation YKUser

//从UserDefaults中获取信息 --返回字符串类型
+ (NSString*)getStringDataFromUserDefaults:(NSString*) key default:(NSString*)defaultValue{
    @try {
        //获取用户轻量级的数据持久化信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        //根据键获取值
        NSString* value = [defaults objectForKey:key];
        
        if(value == nil ||[value isEqualToString:@""]){
            return defaultValue;
        }else{
            return value;
        }
    }
    @catch (NSException *exception) {
    }
    return defaultValue;
}

//从UserDefaults中获取信息 --返回布尔类型
+ (BOOL)getBoolDataFromUserDefaults:(NSString*) key default:(BOOL)defaultValue{
    @try {
        //获取用户轻量级的数据持久化信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        //根据键获取值
        BOOL value = [defaults boolForKey:key];
        return value;
    }
    @catch (NSException *exception) {
    }
    return defaultValue;
}

//将字符串值设置到UserDefaults中
+ (NSString*)putStringDataToUserDefaults:(NSString*) key value:(NSString*)value{
    @try {
        //获取用户轻量级的数据持久化信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:value forKey:key];
    }
    @catch (NSException *exception) {
    }
    return value;
}

//将布尔值设置到UserDefaults中
+ (BOOL)putBoolDataFromUserDefaults:(NSString*) key value:(BOOL)value{
    @try {
        //获取用户轻量级的数据持久化信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:value forKey:key];
    }
    @catch (NSException *exception) {
    }
    return value;
}
@end
