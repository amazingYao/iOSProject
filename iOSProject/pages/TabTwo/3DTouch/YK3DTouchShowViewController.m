//
//  YK3DTouchShowViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YK3DTouchShowViewController.h"

@interface YK3DTouchShowViewController ()
@property (nonatomic, strong)UILabel *labInformation;
@end

@implementation YK3DTouchShowViewController
- (UILabel *)labInformation {
    if (!_labInformation) {
        _labInformation = [[UILabel alloc] init];
    }
    return _labInformation;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"3DTouch预览"];
    [self initUI];
}

-(void)initUI{
    self.labInformation.textColor = [UIColor blackColor];
    self.labInformation.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.labInformation];
    [self.labInformation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(SCREEN_HEIGHT/2-15);
        make.height.equalTo(@(30));
    }];
    self.labInformation.text = [NSString stringWithFormat:@"通过点击[%@]进来的", self.strInfo];
}

//快捷菜单
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    NSMutableArray *arrItem = [NSMutableArray array];
    UIPreviewAction *previewAction0 = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"didClickCancel");
    }];

    UIPreviewAction *previewAction1 = [UIPreviewAction actionWithTitle:@"操作按钮" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        //把下标为index的元素替换成preview
         NSLog(@"didClickAction");
    }];
    
    [arrItem addObjectsFromArray:@[previewAction0 ,previewAction1]];
    
    return arrItem;
}

@end
