//
//  YKThreeViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/3/21.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKThreeViewController.h"
#import "YKGDMapViewController.h"
@interface YKThreeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation YKThreeViewController
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableV.backgroundColor = kWhiteColor;
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.rowHeight = 50;
        
    }
    return _tableV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"常用SDK"];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavBar_Height);
    }];
    [self getData];
}

-(void)getData{
    self.dataArr = @[@"高德地图"];
    [self.tableV reloadData];
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld.%@",indexPath.row + 1,self.dataArr[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = 0;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString *str;
    switch (indexPath.row) {
        case 0:
            str = @"GDMap";
            break;
            
        default:
            break;
    }
     Class class = NSClassFromString([NSString stringWithFormat:@"YK%@ViewController",str]);
    [self.navigationController pushViewController:[class new] animated:YES];
}

@end
