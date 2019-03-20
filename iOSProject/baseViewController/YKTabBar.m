//
//  YKTabBar.m
//  baseFramework
//
//  Created by 姚凯 on 2018/4/27.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "YKTabBar.h"
#import "YKBaseNavigationController.h"
@interface YKTabBar()

/** 新增按钮 */
@property (nonatomic, weak) UIButton *tabbarButton;
/** 新增label*/
@property(nonatomic,strong)UILabel *tabbarLabel;
@end

@implementation YKTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *tabbarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabbarButton.tag = 45;
        [tabbarButton setBackgroundImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
        [tabbarButton sizeToFit];
        [tabbarButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tabbarButton];
        self.tabbarButton = tabbarButton;
        
        UILabel* label = [[UILabel alloc]init];
        label.text = @"新增";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor lightGrayColor];
        [label sizeToFit];
        [self addSubview:label];
        self.tabbarLabel = label;
        
    }
    return self;
}
-(void)publishClick{
//    pageOneViewController *ask=[[pageOneViewController alloc]init];
//    YKBaseNavigationController *navi = [[YKBaseNavigationController alloc] initWithRootViewController:ask];
//    [[self viewController] presentViewController:navi animated:YES completion:nil];
//    
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


/**
 * 布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // tabBar的尺寸
    CGFloat width = self.width;
    CGFloat height = 49;
    
    // 设置发布按钮的位置
    self.tabbarButton.center = CGPointMake(width * 0.5, 0);
    self.tabbarLabel.center = CGPointMake(width * 0.5, 33.5+(self.tabbarLabel.height/2));
    // 按钮索引
    int index = 0;
    
    // 按钮的尺寸
    CGFloat tabBarButtonW = width / 5;
    CGFloat tabBarButtonH = height;
    CGFloat tabBarButtonY = 0;
    
    // 设置4个TabBarButton的frame
    for (UIView *tabBarButton in self.subviews) {
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        CGFloat tabBarButtonX = index * tabBarButtonW;
        if (index >= 2) { // 给后面2个button增加一个宽度的X值
            tabBarButtonX += tabBarButtonW;
        }
        
        // 设置按钮的frame
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        index++;
    }
    
   
}

@end
