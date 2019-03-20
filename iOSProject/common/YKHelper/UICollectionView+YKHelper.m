//
//  UICollectionView+YKHelper.m
//  ZBUnsecuredLoan
//
//  Created by 姚凯 on 2018/9/12.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "UICollectionView+YKHelper.h"

@implementation UICollectionView (YKHelper)
- (void)reloadIndexSection:(NSInteger)section{
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self reloadSections:indexSet];
}

- (void)reloadIndexSection:(NSInteger)section IndexRow:(NSInteger)row{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)zy_registNib:(Class)aClass {
    NSString *name = NSStringFromClass(aClass);
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forCellWithReuseIdentifier:name];
}

- (void)zy_registClass:(Class)aClass {
    NSString *name = NSStringFromClass(aClass);
    [self registerClass:aClass forCellWithReuseIdentifier:name];
}

- (void)zy_registHeader:(Class)aClass {
    NSString *name = NSStringFromClass(aClass);
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:name];
}

- (void)zy_registFooter:(Class)aClass {
    NSString *name = NSStringFromClass(aClass);
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:name];
}
@end
