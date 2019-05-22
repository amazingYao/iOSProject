//
//  YKTakePhotoViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/6.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKTakePhotoViewController.h"
#import "TZImagePickerController.h"
@interface YKTakePhotoViewController ()<TZImagePickerControllerDelegate>
@property (nonatomic,strong) UIImageView *imgV;
@end

@implementation YKTakePhotoViewController
-(UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
    }
    return _imgV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self initUI];
}

-(void)initUI{
    [self titleIS:@"选取照片"];
    [self setNavigationRightBarButtonWithString:@"拍摄"];
    [self.view addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(@300);
    }];
}
-(void)rightBAction{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    [alertVc addAction:takePhotoAction];
    UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    [alertVc addAction:imagePickerAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}



- (void)takePhoto{
    
}

- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    // 2. 在这里设置imagePickerVc的外观
     imagePickerVc.navigationBar.barTintColor =  RGB(50, 180, 222);//导航栏颜色
     imagePickerVc.navigationBar.translucent = NO;
    
    //选中图片右上角颜色
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    
    //不能选择图片后蒙版颜色
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    //右下角完成按钮颜色
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor: RGB(50, 180, 222) forState:UIControlStateNormal];
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    }];
    
    //显示内部拍摄n按钮
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.showSelectedIndex = YES;
    
    //单选模式
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES;
    
    
    //设置图片大小
    NSInteger left = 30;
    NSInteger widthHeight = SCREEN_WIDTH - 2 * left;
    NSInteger top = (SCREEN_HEIGHT - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.imgV.image = photos[0];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
@end
