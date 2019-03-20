//
//  YKImagePicker.m
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "YKImagePicker.h"

@interface YKImagePicker()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, copy) YKImagePickerFinishAction finishAction;
@property (nonatomic, assign) BOOL allowsEditing;

@end

static YKImagePicker *ykImagePickerInstance = nil;
@implementation YKImagePicker
+ (void)showImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(YKImagePickerFinishAction)finishAction {
    if (ykImagePickerInstance == nil) {
        ykImagePickerInstance = [[YKImagePicker alloc] init];
    }
    
    [ykImagePickerInstance showImagePickerFromViewController:viewController
                                               allowsEditing:allowsEditing
                                                finishAction:finishAction];
}

+ (void)showCameraFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(YKImagePickerFinishAction)finishAction {
    if (ykImagePickerInstance == nil) {
        ykImagePickerInstance = [[YKImagePicker alloc] init];
    }
    
    [ykImagePickerInstance showCameraFromViewController:viewController
                                          allowsEditing:allowsEditing
                                           finishAction:finishAction];
}

+ (void)showLibrayFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(YKImagePickerFinishAction)finishAction {
    if (ykImagePickerInstance == nil) {
        ykImagePickerInstance = [[YKImagePicker alloc] init];
    }
    
    [ykImagePickerInstance showLibrayFromViewController:viewController
                                          allowsEditing:allowsEditing
                                           finishAction:finishAction];
}


- (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(YKImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditing;

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = self.allowsEditing;
        [viewController presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker.navigationBar setBarTintColor:[UIColor blackColor]];
        picker.allowsEditing = self.allowsEditing;
        [viewController presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         ykImagePickerInstance = nil;
    }];
    
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [viewController presentViewController:actionSheet animated:YES completion:nil];
}


- (void)showCameraFromViewController:(UIViewController *)viewController
                       allowsEditing:(BOOL)allowsEditing
                        finishAction:(YKImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditing;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = _allowsEditing;
    [_viewController presentViewController:picker animated:YES completion:nil];
}

- (void)showLibrayFromViewController:(UIViewController *)viewController
                       allowsEditing:(BOOL)allowsEditing
                        finishAction:(YKImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditing;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = _allowsEditing;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [_viewController presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    if (_finishAction) {
        _finishAction(image);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    ykImagePickerInstance = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (_finishAction) {
        _finishAction(nil);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    ykImagePickerInstance = nil;
}
@end
