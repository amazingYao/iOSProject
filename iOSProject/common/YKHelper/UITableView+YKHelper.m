//
//  UITableView+YKHelper.m
//  ZBUnsecuredLoan
//
//  Created by 姚凯 on 2018/9/12.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "UITableView+YKHelper.h"

@implementation UITableView (YKHelper)
- (void)reloadIndexSection:(NSInteger)section{
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadIndexSection:(NSInteger)section IndexRow:(NSInteger)row{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - 注册方法 注:想要使用者两个方法,需要保证重用标识符和类名相同
- (void)zy_registNibCell:(Class)aClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(aClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(aClass)];
}

- (void)zy_registClassCell:(Class)aClass {
    [self registerClass:aClass forCellReuseIdentifier:NSStringFromClass(aClass)];
}
@end
