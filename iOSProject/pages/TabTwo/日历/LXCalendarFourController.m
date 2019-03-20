//
//  LXCalendarFourController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/3/20.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "LXCalendarFourController.h"
#import "CalenderView.h"
@interface LXCalendarFourController ()<CalenderViewDelete>

@end

@implementation LXCalendarFourController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleIS:@"竖向滑动 单选"];
    
    NSDate *datenow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    CalenderView *view = [[CalenderView alloc] initWithFrame:CGRectMake(0, NavBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-NavBar_Height) startDay:@"2018-5-1" endDay:currentTimeString];
    view.delegate = self;
    view.yearMonthFormat = @"%zd年%02zd月";
    view.actvityColor = YES;
    view.showWeekBottomLine = YES;
    view.isSingleChoose = YES;
    [self.view addSubview:view];
    
}

-(void)calenderView:(NSIndexPath *)indexPath dateString:(NSString *)dateString {
    NSLog(@"%@",dateString);
}

@end
