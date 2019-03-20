//
//  YKTextLBViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/3.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKTextLBViewController.h"

@interface YKTextLBViewController ()<SDCycleScrollViewDelegate>

@end

@implementation YKTextLBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self titleIS:@"文字轮播"];
    //受限于SDK，样式较为固定 不一定能满足需求 推荐使用图片轮播中的自定义样式  通过自定义样式一样可以实现文字轮播功能
    
    
    // 网络加载 --- 创建只上下滚动展示文字的轮播器
    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, NavBar_Height, SCREEN_WIDTH, 40) delegate:self placeholderImage:nil];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.onlyDisplayText = YES;
    NSArray *titles = @[@"文字滚动1111",
                        @"文字滚动2222",
                        @"文字滚动3333",
                        @"文字滚动4444",
                        @"文字滚动5555"
                        ];

    cycleScrollView.titlesGroup = [titles copy];
    cycleScrollView.backgroundColor = [UIColor whiteColor];
    [cycleScrollView disableScrollGesture];
    [self.view addSubview:cycleScrollView];
    
    
    
}

@end
