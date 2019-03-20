//
//  YKCollectionHViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/30.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKCollectionHViewController.h"
#import "FlyHorizontalFlowLauyout.h"
#import "YKCollectionVViewCell.h"
@interface YKCollectionHViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionV;
@end

@implementation YKCollectionHViewController
-(UICollectionView *)collectionV{
    if (!_collectionV) {
        FlyHorizontalFlowLauyout *horizontalLayout = [[FlyHorizontalFlowLauyout alloc] init];
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:horizontalLayout];
    }
    return _collectionV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    [self titleIS:@"左右滚动"];
    self.collectionV.backgroundColor =kWhiteColor;
    self.collectionV.dataSource = self;
    self.collectionV.delegate = self;
    self.collectionV.showsHorizontalScrollIndicator = NO;
    self.collectionV.bounces = NO;
    self.collectionV.pagingEnabled = YES;
    [self.view addSubview:_collectionV];
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(NavBar_Height);
        make.height.equalTo(@(SCREEN_WIDTH));
    }];
    [self.collectionV zy_registNib:[YKCollectionVViewCell class]];
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YKCollectionVViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"YKCollectionVViewCell" forIndexPath:indexPath];
    cell.tittleLab.text = [NSString stringWithFormat:@"这是第%ld分区",indexPath.section+1];
    cell.subTittleLab.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row+1];
    cell.tittleLab.font = TextFont(10);
    cell.subTittleLab.font = TextFont(8);
    [YKHelper namedImageView:cell.imgV With:[NSString stringWithFormat:@"dota-%ld",indexPath.section%5+1]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld分区，第%ld行！",indexPath.section+1,indexPath.row+1);
}

////设置距离
//cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH - 30 - 1.5)/4, (SCREEN_WIDTH - 30 - 1.5)/4);
}

//设置分区距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15,15,15,15);//上 左 下 右
}
//设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}


-(void)dealloc{
    NSLog(@"CollectionView左右滚动页面销毁了");
}
@end
