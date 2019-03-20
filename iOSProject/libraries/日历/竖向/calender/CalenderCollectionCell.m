//
//  CalenderCollectionCell.m
//  YZCCalender
//
//  Created by Jason on 2018/1/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CalenderCollectionCell.h"
#import "CalenderModel.h"
#import "UIColor+Extension.h"

@interface CalenderCollectionCell()
@property (nonatomic,strong) UILabel *todayLab;
@end

@implementation CalenderCollectionCell

#pragma mark - lazy


- (UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.5 - 30 * 0.5, self.frame.size.height * 0.5 - 30 * 0.5, 30, 30)];
        _numberLabel.textAlignment   = NSTextAlignmentCenter;
        _numberLabel.font            = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_numberLabel];
    }
    return _numberLabel;
}

-(UILabel *)todayLab{
    if (_todayLab == nil) {
        _todayLab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-30, 0, 30, 20)];
        _todayLab.textColor = [UIColor orangeColor];
        _todayLab.text = @"今天";
        _todayLab.font  = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_todayLab];
    }
    return _todayLab;
}

-(void)setModel:(CalenderModel *)model {
    _model = model;
    self.numberLabel.text = model.day;
    if (model.isSelected) {
        self.numberLabel.textColor = model.activityColor;
        self.numberLabel.backgroundColor = [UIColor redColor];
    }else{
        self.numberLabel.backgroundColor = [UIColor clearColor];
        self.numberLabel.textColor = model.activityColor ? model.activityColor : [UIColor colorWithHexString:@"#000000" alpha:0.15];
    }
    if (model.isWeekend) {
        if (model.isSelected) {
            self.numberLabel.textColor = model.activityColor;
            self.numberLabel.backgroundColor = [UIColor redColor];
        }else{
            self.numberLabel.textColor = [UIColor redColor];
            self.numberLabel.backgroundColor = [UIColor clearColor];
        }
    }
    self.todayLab.hidden = !model.isToday;
    
    if (model.isIncluded) {
        if (model.day.length) {
            self.numberLabel.backgroundColor = [UIColor blueColor];
        }
    }

}

@end

