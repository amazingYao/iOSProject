//
//  YKCollectionViewVViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/29.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKCollectionViewVViewController.h"
#import "YKCollectionVViewCell.h"
#import "YKVCHeaderView.h"
@interface YKCollectionViewVViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionV;
@end

@implementation YKCollectionViewVViewController

-(UICollectionView *)collectionV{
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc] init];
    }
    return _collectionV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self titleIS:@"上下滑动"];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionV.backgroundColor = kWhiteColor;
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.showsVerticalScrollIndicator = NO;
    //初始偏移量 可以不用设置
    _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //分页属性 默认为NO
    _collectionV.pagingEnabled = NO;
    //取消弹簧效果（与MJRefresh冲突，设置为NO时无法上拉和下拉）
//    _collectionV.bounces = NO;
    [self.view addSubview:self.collectionV];
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavBar_Height);
    }];
    [self.collectionV zy_registNib:[YKCollectionVViewCell class]];
    [self.collectionV zy_registHeader:[YKVCHeaderView class]];
    [self.collectionV zy_registFooter:[YKVCHeaderView class]];

      __weak __typeof__(self) weakSelf = self;
    // 下拉刷新
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf getData1];
    }];
    // 上拉刷新
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf getData2];
    }];
}
-(void)getData1{
    __weak __typeof__(self) weakSelf = self;
    [YKAlter show:@"正在加载"];
    [YKHttp getRequestWithURLStr:@"https://www.apiopen.top/novelApi" params:nil success:^(NSDictionary *responseDic) {
        [weakSelf.collectionV.mj_header endRefreshing];
        [YKAlter dismiss];

    } failure:^(NSError *error) {
        [YKAlter dismiss];
        [weakSelf.collectionV.mj_header endRefreshing];
    }];
}
-(void)getData2{
    __weak __typeof__(self) weakSelf = self;
    [YKAlter show:@"正在加载"];
    [YKHttp getRequestWithURLStr:@"https://www.apiopen.top/novelApi" params:nil success:^(NSDictionary *responseDic) {
        [weakSelf.collectionV.mj_footer endRefreshing];
        [YKAlter dismiss];
    } failure:^(NSError *error) {
        [YKAlter dismiss];
        [weakSelf.collectionV.mj_footer endRefreshing];
    }];
}
#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YKCollectionVViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"YKCollectionVViewCell" forIndexPath:indexPath];
    cell.tittleLab.text = [NSString stringWithFormat:@"这是第%ld分区",indexPath.section+1];
    cell.subTittleLab.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row+1];
    [YKHelper namedImageView:cell.imgV With:[NSString stringWithFormat:@"dota-%ld",indexPath.section%5+1]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld分区，第%ld行！",indexPath.section+1,indexPath.row+1);
}

//设置距离
//cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2);
}

//设置分区距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,10,0,10);//上 左 下 右
}
//设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//设置sectionHeader | sectionFoot
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YKVCHeaderView *view = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YKVCHeaderView" forIndexPath:indexPath];
        view.tittleLab.text = [NSString stringWithFormat:@"-----这是第%ld个分区的header-----",(long)indexPath.section+1];
        view.backgroundColor = [UIColor orangeColor];
        return view;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        YKVCHeaderView *view = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YKVCHeaderView" forIndexPath:indexPath];
        view.tittleLab.text = [NSString stringWithFormat:@"-----这是第%ld个分区的footer-----",(long)indexPath.section+1];
        view.backgroundColor = [UIColor purpleColor];
        return view;
    }
    return nil;
}
//执行的 headerView 代理  返回 headerView 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/20);
}




@end
