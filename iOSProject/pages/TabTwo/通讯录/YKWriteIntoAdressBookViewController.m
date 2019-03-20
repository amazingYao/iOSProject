//
//  YKWriteIntoAdressBookViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/4.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKWriteIntoAdressBookViewController.h"
#import <ContactsUI/CNContactViewController.h>
#import <ContactsUI/CNContactPickerViewController.h>
#import "LJContactManager.h"
@interface YKWriteIntoAdressBookViewController ()

@end

@implementation YKWriteIntoAdressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self titleIS:@"写入通讯录"];
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"写入通讯录" forState:UIControlStateNormal];
    [btn setTintColor:kWhiteColor];
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.equalTo(@(100));
        make.top.offset(NavBar_Height);
    }];
}
-(void)save{
    [YKAlter alert:[NSArray arrayWithObjects:@"创建新联系人",@"添加到现有联系人", nil] Tittle:@"添加到通讯录" Msg:nil WithController:self ChooseAction:^(NSInteger index) {
        if (index == 0) {
            [self addNew];
        }else{
            [self addToExist];
        }
    }];
}

//添加新联系人
-(void)addNew{
     [[LJContactManager sharedInstance] createNewContactWithPhoneNum:@"19966699666" controller:self];
}
-(void)addToExist{
     [[LJContactManager sharedInstance] addToExistingContactsWithPhoneNum:@"19966699666" controller:self];
}

@end
