//
//  YKGetPeopleAdressViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/5.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKGetPeopleAdressViewController.h"
#import "LJContactManager.h"
@interface YKGetPeopleAdressViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation YKGetPeopleAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}
-(void)initUI{
    [self titleIS:@"获取联系人信息"];
}
- (IBAction)getData:(id)sender {
    [[LJContactManager sharedInstance] selectContactAtController:self complection:^(NSString *name, NSString *phone) {
        self.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",name];
        self.phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",phone];
    }];
}

@end
