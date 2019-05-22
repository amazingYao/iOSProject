//
//  YKFourViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/4/28.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKFourViewController.h"

@interface YKFourViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation YKFourViewController

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
    [self titleIS:@"功能"];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavBar_Height);
    }];
    [self getData];
}

-(void)getData{
    self.dataArr = @[@"图片加水印",@"图片水印二",@"修改RootView"];
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
    switch (indexPath.row) {
        case 0:
            [self pusuView:@"ImageMask"];
            break;
        case 1:
            [self pusuView:@"ImageHandle"];
            break;
        case 2:
            [self presectView:@"Reset"];
            break;
        default:
            break;
    }
   
}

-(void)presectView:(NSString *)name{
    Class class = NSClassFromString([NSString stringWithFormat:@"YK%@ViewController",name]);
    [self presentViewController:[class new] animated:YES completion:nil];
}

-(void)pusuView:(NSString *)name{
    Class class = NSClassFromString([NSString stringWithFormat:@"YK%@ViewController",name]);
    [self.navigationController pushViewController:[class new] animated:YES];
}

@end
