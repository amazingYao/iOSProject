//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//


/**
 这个簇类拓展修改navi颜色 
 scroll滚动的时候配合这个 可以沉浸式状态栏
 */

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
@end
