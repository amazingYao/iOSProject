//
//  YKGetAdressBookViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/4.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKGetAdressBookViewController.h"
#import "LJPerson.h"
#import "LJContactManager.h"
#import "YKAdressBookTableViewCell.h"
@interface YKGetAdressBookViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSArray *keys;
@end

@implementation YKGetAdressBookViewController
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableV;
}
-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSArray alloc] init];
    }
    return _dataSource;
}
-(NSArray *)keys{
    if (!_keys) {
        _keys = [[NSArray alloc] init];
    }
    return _keys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    [self getData];
}

-(void)initUI{
    [self titleIS:@"获取通讯录"];
    self.tableV.backgroundColor = kWhiteColor;
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.rowHeight = 60;
    [self.tableV zy_registNibCell:[YKAdressBookTableViewCell class]];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.offset(NavBar_Height);
    }];
}

-(void)getData{
    [[LJContactManager sharedInstance] accessSectionContactsComplection:^(BOOL succeed, NSArray<LJSectionPerson *> *contacts, NSArray<NSString *> *keys) {
        self.dataSource = contacts;
        self.keys = keys;
        [self.tableV reloadData];
    }];
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LJSectionPerson *sectionModel = self.dataSource[section];
    return sectionModel.persons.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YKAdressBookTableViewCell *cell = [_tableV dequeueReusableCellWithIdentifier:@"YKAdressBookTableViewCell" forIndexPath:indexPath];
    LJSectionPerson *sectionModel = self.dataSource[indexPath.section];
    LJPerson *personModel = sectionModel.persons[indexPath.row];
    cell.model = personModel;
    return cell;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    LJSectionPerson *sectionModel = self.dataSource[section];
    return sectionModel.key;
}
//右侧的索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _keys;
}



@end
