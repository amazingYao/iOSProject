//
//  YKImagePicker.h
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^YKImagePickerFinishAction)(UIImage *image);

@interface YKImagePicker : NSObject
/**
 @param viewController  用于present UIImagePickerController对象
 @param allowsEditing   是否允许用户编辑图像
 */
+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(YKImagePickerFinishAction)finishAction;


+ (void)showCameraFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(YKImagePickerFinishAction)finishAction;

+ (void)showLibrayFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(YKImagePickerFinishAction)finishAction;
@end
