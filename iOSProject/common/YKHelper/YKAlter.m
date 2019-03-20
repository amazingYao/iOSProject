//
//  YKAlter.m
//  baseFramework
//
//  Created by 姚凯 on 2018/10/18.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKAlter.h"
#import <UIView+Toast.h>
@interface YKAlter()
@end

@implementation YKAlter
+(void)show:(NSString *)msg{
    [SVProgressHUD showWithStatus:msg];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

+(void)dismiss{
    [SVProgressHUD dismiss];
}


+(void)alertWithTittle:(NSString * __nullable)tittle Msg:(NSString * __nullable)msg cancleBtn:(NSString * __nullable)cancleBtn otherBtn:(NSString *)otherBtn WithController:(UIViewController *)controller ChooseAction:(void (^)(NSString *action))chooseAction{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:tittle message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:otherBtn style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (chooseAction) {
            chooseAction(@"agree");
        }
    }];
    [actionSheet addAction:action];
    
    if (![YKHelper isNull:cancleBtn]) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleBtn style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (chooseAction) {
                chooseAction(@"cancle");
            }
        }];
        [actionSheet addAction:cancleAction];
    }

    [controller presentViewController:actionSheet animated:YES completion:nil];
}

+(void)alert:(NSArray *)msgArr Tittle:(NSString * __nullable)tittle Msg:(NSString * __nullable)msg WithController:(UIViewController *)controller ChooseAction:(void (^)(NSInteger index))chooseAction{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:tittle message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<msgArr.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:msgArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (chooseAction) {
                chooseAction(i);
            }
        }];
         [actionSheet addAction:action];
    }

    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:cancleAction];
    [controller presentViewController:actionSheet animated:YES completion:nil];
}

+(void)textAlertTittle:(NSString * __nullable)tittle Msg:(NSString * __nullable)msg Placeholder:(NSString * __nullable)placeholder WithController:(UIViewController *)controller ChooseAction:(void (^)(NSString *action))chooseAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:tittle message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (chooseAction) {
            chooseAction(alert.textFields.lastObject.text);
            
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [controller presentViewController:alert animated:YES completion:nil];
}


+(void)makeTost:(NSString *)msg View:(UIView *)view{
    [view  makeToast:msg duration:1 position: @"CSToastPositionCenter"];
}
@end
