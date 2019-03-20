//
//  YKImageLBViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/3.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKImageLBViewController.h"
#import "YKLBCustomCell.h"
@interface YKImageLBViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)   SDCycleScrollView *customCellScrollViewDemo;
@end

@implementation YKImageLBViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    //    [你的CycleScrollview adjustWhenControllerViewWillAppera];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self titleIS:@"图片轮播"];
    self.view.backgroundColor = kBlackColor;
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    UIView * container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    NSArray *arr = [NSArray arrayWithObjects:@"上下滚动",@"左右滚动 自定义分页控件图片",@"带标题左右滚动",@"自定义试图", nil];
    for (int i = 0; i<arr.count; i++) {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:view];
        view.tag = 100+i;
        if (i == 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(scrollView);
                make.height.mas_equalTo(250);
            }];
        }else if (i == arr.count-1){
            UIView *topView = [self.view viewWithTag:100+i-1];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(topView.mas_bottom).offset(1);
                make.left.right.equalTo(scrollView);
                make.height.mas_equalTo(250);
                make.bottom.equalTo(container);
            }];
        }else{
            UIView *topView = [self.view viewWithTag:100+i-1];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(topView.mas_bottom).offset(1);
                make.left.right.equalTo(scrollView);
                make.height.mas_equalTo(250);
            }];
        }
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = TextFont(20);
        lab.text = arr[i];
        [view addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
            make.height.equalTo(@(50));
        }];
    }
    
    [self createImageView];
}

//创建轮播图试图 单独写方法 以便阅读
-(void)createImageView{
    /******************不带标题 上下滑动 本地加载*************************/
    UIView *view1 = [self.view viewWithTag:100];
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg"
                            ];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [view1 addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    /******************左右滑动 网络加载  自定义pageController图片*************************/
    UIView *view2 = [self.view viewWithTag:101];
    //网路图片路径数组
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    //placeholderImage 未加载出来时的图片
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //当前状态小圆点图片
    cycleScrollView2.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    //非当前状态小圆点图片
    cycleScrollView2.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    [view2 addSubview:cycleScrollView2];
    
    
    
    /******************带标题 左右滑动 网络加载*************************/
    UIView *view3 = [self.view viewWithTag:102];
    NSArray *titles = @[@"测试标题一",
                        @"测试标题二",
                        @"测试标题三"
                        ];
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView3.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView3.titlesGroup = titles;
    //也可自定义分页控件图片或颜色
//    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView3.currentPageDotColor = [UIColor redColor]; // 自定义分页控件小圆标颜色
    [cycleScrollView3 disableScrollGesture];//禁用滚动手势
    cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
    [view3 addSubview:cycleScrollView3];
    
    
    
    /******************自定义试图*************************/
    UIView *view4 = [self.view viewWithTag:103];
    _customCellScrollViewDemo = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200) delegate:self placeholderImage:nil];
    //受限于SDK，需要通过imageURLStringsGroup的值来确定轮播图数量 所以想下吗一样传入数组即可
    NSArray *arr = [NSArray arrayWithObjects:@"",@"",@"",@"", nil];
    _customCellScrollViewDemo.imageURLStringsGroup = arr;
    _customCellScrollViewDemo.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    [view4 addSubview:_customCellScrollViewDemo];
    
}
#pragma mark - SDCycleScrollViewDelegate
// 点击第几张图
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
  
}

 - (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
     
 }


// 不需要自定义轮播cell的请忽略下面的代理方法
// 如果要实现自定义cell的轮播图，必须先实现customCollectionViewCellClassForCycleScrollView:和setupCustomCell:forIndex:代理方法
// 受限于SDK暂不支持通过xib自定义cell
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    if (view != _customCellScrollViewDemo) {
        return nil;
    }
    return [YKLBCustomCell class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    YKLBCustomCell *myCell = (YKLBCustomCell *)cell;
    [YKHelper namedImageView:myCell.imageView With:[NSString stringWithFormat:@"h%ld",index+1]];
    myCell.tittleLabel.text = [NSString stringWithFormat:@"测试标题%ld",index+1];
    myCell.indexLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)index+1,(unsigned long)view.imageURLStringsGroup.count];
}
@end
