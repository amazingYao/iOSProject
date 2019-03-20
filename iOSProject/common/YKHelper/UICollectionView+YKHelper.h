//
//  UICollectionView+YKHelper.h
//  CollectionView方法
//
//  Created by 姚凯 on 2018/9/12.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (YKHelper)
#pragma mark - 刷新方法
/**
    刷新某一分区
 */
- (void)reloadIndexSection:(NSInteger)section;

/**
    刷新某一段某一分区某一行
 */
- (void)reloadIndexSection:(NSInteger)section IndexRow:(NSInteger)row;

#pragma mark - 注册方法 注:想要使用者两个方法,需要保证重用标识符和类名相同
/**
    注册带有Xib的单元格
 */
- (void)zy_registNib:(Class)aClass;
/**
    注册类的单元格
 */
- (void)zy_registClass:(Class)aClass;
/**
    注册带有Xib的区头
 */
- (void)zy_registHeader:(Class)aClass;
/**
    注册带有Xib的区尾
 */
- (void)zy_registFooter:(Class)aClass;
@end
