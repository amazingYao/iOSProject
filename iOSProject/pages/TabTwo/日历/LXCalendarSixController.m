//
//  LXCalendarSixController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/3/20.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "LXCalendarSixController.h"
#import "ASDayPicker.h"
@interface LXCalendarSixController ()

@property (nonatomic,strong)ASDayPicker *dayPicker;
@end

@implementation LXCalendarSixController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *endDateSting = @"2030-12-31";
    NSDate *endDate = [formatter dateFromString:endDateSting];
    NSLog(@"%@",endDate);
    
    
    self.dayPicker = [[ASDayPicker alloc] init];
//    self.dayPicker.selectedDateBackgroundImage = [UIImage imageNamed:@"selection"];
    self.dayPicker.selectedDateTextColor = [UIColor redColor];
    [self.dayPicker setStartDate:[NSDate date] endDate:endDate];
    [self.dayPicker addObserver:self forKeyPath:@"selectedDate" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self.dayPicker addObserver:self forKeyPath:@"beginDate" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.dayPicker];
    [self.dayPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@80);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSDate *day = change[NSKeyValueChangeNewKey];
    NSString *str =  [NSDateFormatter localizedStringFromDate:day dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    if ([keyPath isEqualToString:@"selectedDate"]) {
        NSLog(@"当前选中日期=====%@",str);
    }else{
        NSLog(@"当前所处日期=====%@",str);
    }
    
}

@end
