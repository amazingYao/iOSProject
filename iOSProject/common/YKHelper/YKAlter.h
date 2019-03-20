//
//  YKAlter.h
//  baseFramework
//
//  Created by 姚凯 on 2018/10/18.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^YKAlertChooseAction)(NSString *chooseAction);

@interface YKAlter : NSObject
#pragma mark - toast
+(void)show:(NSString *)msg;
+(void)dismiss;

#pragma mark - alertView
+(void)alertWithTittle:(NSString * __nullable)tittle Msg:(NSString * __nullable)msg cancleBtn:(NSString * __nullable)cancleBtn otherBtn:(NSString *)otherBtn WithController:(UIViewController *)controller ChooseAction:(void (^)(NSString *action))chooseAction;


/**
    sheet 多选项
 */
+(void)alert:(NSArray *)msgArr Tittle:(NSString * __nullable)tittle Msg:(NSString * __nullable)msg WithController:(UIViewController *)controller ChooseAction:(void (^)(NSInteger index))chooseAction;

+(void)textAlertTittle:(NSString * __nullable)tittle Msg:(NSString * __nullable)msg Placeholder:(NSString * __nullable)placeholder WithController:(UIViewController *)controller ChooseAction:(void (^)(NSString *action))chooseAction;


#pragma mark - Toast
+(void)makeTost:(NSString *)msg View:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
