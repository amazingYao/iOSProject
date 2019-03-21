//
//  CircleWithTextProgressView.h
//  SHProgressView
//
//  Created by zxy on 16/3/16.
//  Copyright © 2016年 Chenshaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleWithTextProgressView : UIView

@property (nonatomic,assign) CGFloat percent;

@property (nonatomic,assign) CGFloat  lineWidth;

@property (strong, nonatomic) NSTimer *timer;

@property (strong,nonatomic) UIColor *upperLineCollor;
@end
