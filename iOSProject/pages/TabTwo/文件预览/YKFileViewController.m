//
//  YKFileViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/3.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKFileViewController.h"
#import <QuickLook/QuickLook.h>
#import "YKWKwebViewViewController.h"
@interface YKFileViewController ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate,QLPreviewControllerDelegate,QLPreviewControllerDataSource>
@property (nonatomic,strong) UITableView *tableV;
@end

@implementation YKFileViewController
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
   
}
-(void)initUI{
    [self titleIS:@"文件预览"];
    self.tableV.backgroundColor = kWhiteColor;
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.rowHeight = 50;
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.offset(NavBar_Height);
    }];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld.UIDocumentInteractionController",(long)indexPath.row+1];
    }else if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld.quickLook",(long)indexPath.row+1];
    }else{
         cell.textLabel.text = [NSString stringWithFormat:@"%ld.webView",(long)indexPath.row+1];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = 0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self UIDocumentInteractionController];
    }else if(indexPath.row == 1){
        [self quickLook];
    }else{
        YKWKwebViewViewController *vc = [[YKWKwebViewViewController alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Codelife" ofType:@"pdf"];
        NSURL *url = [NSURL fileURLWithPath:path];
        vc.urlStr = [url absoluteString];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - UIDocumentInteractionController
-(void)UIDocumentInteractionController{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Codelife" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL:url];
    interactionController.delegate = self;
    [interactionController presentPreviewAnimated:YES];
    
    //直接打开分享页面
//    [interactionController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];

}
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

#pragma mark - quickLook
-(void)quickLook{
    QLPreviewController *qlController = [[QLPreviewController alloc]init];
    qlController.delegate = self;
    qlController.dataSource = self;
    [qlController setCurrentPreviewItemIndex:0];
    [self presentViewController:qlController animated:YES completion:nil];
}
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Codelife" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    return url;
}
- (void)previewControllerDidDismiss:(QLPreviewController *)controller{
    NSLog(@"预览界面已经消失");
}

//文件内部链接点击不进行外部跳转
- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item{
    return NO;
}

@end
