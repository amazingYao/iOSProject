//
//  CalenderHeaderView.m
//  YZCCalender
//
//  Created by Jason on 2018/1/18.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CalenderHeaderView.h"
#import "UIColor+Extension.h"

@implementation CalenderHeaderView

- (UILabel *)yearAndMonthLabel {
    if (_yearAndMonthLabel == nil) {
        _yearAndMonthLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , self.frame.size.width, self.frame.size.height)];
        _yearAndMonthLabel.textAlignment   = NSTextAlignmentCenter;
        _yearAndMonthLabel.font            = [UIFont systemFontOfSize:20];
        _yearAndMonthLabel.textColor       = [UIColor colorWithHexString:@"#000000"];
        [self addSubview:_yearAndMonthLabel];
    }
    return _yearAndMonthLabel;
}


@end
