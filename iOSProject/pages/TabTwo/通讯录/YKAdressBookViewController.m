//
//  YKAdressBookViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/4.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKAdressBookViewController.h"
#import "YKGetAdressBookViewController.h"
#import "YKWriteIntoAdressBookViewController.h"
#import "YKGetPeopleAdressViewController.h"
#import <Contacts/Contacts.h>
@interface YKAdressBookViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@end

@implementation YKAdressBookViewController

-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestAuthorization];
}
-(void)initUI{
    [self titleIS:@"通讯录"];
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
        cell.textLabel.text = [NSString stringWithFormat:@"%ld.获取通讯录",(long)indexPath.row+1];
    }else if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld.写入通讯录",(long)indexPath.row+1];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%ld.获取单个联系人",(long)indexPath.row+1];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = 0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YKGetAdressBookViewController *vc = [[YKGetAdressBookViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        YKWriteIntoAdressBookViewController *vc = [[YKWriteIntoAdressBookViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIStoryboard *SB =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        YKGetPeopleAdressViewController *vc = [SB instantiateViewControllerWithIdentifier:@"GPAB"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}






-(void)requestAuthorization{
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] != CNAuthorizationStatusAuthorized){
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!granted) {
                NSLog(@"授权失败");
                [YKAlter alertWithTittle:@"提示" Msg:@"请在iPhone的“设置-隐私-通讯录”选项中，允许访问您的通讯录" cancleBtn:@"知道了" otherBtn:@"前往设置" WithController:self ChooseAction:^(NSString * _Nonnull action) {
                    if ([action isEqualToString:@"agree"]) {
                        [kApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }
                }];
            }
        }];
    }
    
    

}
@end
