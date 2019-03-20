//
//  YKSystem.m
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "YKSystem.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
@implementation YKSystem
+ (NSString*)getCurrentVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (float)getCurrentSystemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}



+(NSString *)getDeviceType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    return platform;
    
}

+(void)checkNewApp{
//    [HttpTool postRequestWithURLStr:@"https://itunes.apple.com/lookup?id=1237039077" params:nil success:^(NSDictionary *responseDic) {
//        NSArray *array = responseDic[@"results"];
//        NSDictionary *dict = [array lastObject];
//        NSLog(@"当前版本为：%@", dict[@"version"]);
//        NSString *releaseNotes = [NSString stringWithFormat:@"本次更新内容：%@",dict[@"releaseNotes"]];
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//        if ([dict[@"version"] floatValue] >[app_Version floatValue] ) {
//            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"有新版本可以更新" message:releaseNotes delegate:nil cancelButtonTitle:@"暂不更新" otherButtonTitles:@"去更新" ,nil];
//            alertV.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {
//                if(index == 0)
//                {
//                }else
//                {
//                    [kApplication openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%91%A1%E8%90%84%E5%A1%98/id123703907?mt=8"]];
//                }
//            };
//            [alertV show];
//        }
//    } failure:^(NSError *error) {
//
//    }];
}

@end
