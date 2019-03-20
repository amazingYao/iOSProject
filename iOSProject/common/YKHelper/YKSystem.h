//
//  YKSystem.h
//  baseFramework
//  系统配置获取
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKSystem : NSObject
/**
     获取当前客户端版本号
 */
+ (NSString *)getCurrentVersion;

/**
    获取当前操作系统版本
 */
+ (float)getCurrentSystemVersion;


/**
    获取设备机型
 */
+ (NSString*)getDeviceType;

/**
    判断是否有更新
 */
+(void)checkNewApp;




@end
