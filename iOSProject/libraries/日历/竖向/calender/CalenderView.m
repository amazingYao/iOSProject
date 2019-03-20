//
//  CalenderView.m
//  YZCCalender
//
//  Created by Jason on 2018/1/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CalenderCollectionCell.h"
#import "CalenderHeaderView.h"
#import "CalenderModel.h"
#import "CalenderView.h"
#import "CalenderWeekView.h"
#import "NSDate+Extension.h"
#import "UIColor+Extension.h"

@interface CalenderView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) CalenderWeekView *weekView;
@property (nonatomic, strong) NSIndexPath      *lastIndexPath;

@property (nonatomic, copy) NSString *startDay;
@property (nonatomic, copy) NSString *endDay;


// 以下为选所需变量
@property (nonatomic,strong) NSIndexPath *startIndexPath;
@property (nonatomic,strong) NSIndexPath *endIndexPath;


@end

static NSString *const reuseIdentifier  = @"collectionViewCell";
static NSString *const headerIdentifier = @"headerIdentifier";

@implementation CalenderView

- (instancetype)initWithFrame:(CGRect)frame startDay:(NSString *)startDay endDay:(NSString *)endDay {
    self = [super initWithFrame:frame];
    if (self) {
        self.startDay = startDay;
        self.endDay   = endDay;
        [self buildSource];
        [self addSubview:self.weekView];
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - 设置数据源
- (void)buildSource {
    NSAssert(self.startDay.length && self.endDay.length, @"开始时间和结束时间不能为空");
    if (!self.startDay.length || !self.endDay.length) {
        self.startDay = [NSDate timeStringWithInterval:[NSDate date].timeIntervalSince1970];
        self.endDay   = [NSDate timeStringWithInterval:[NSDate date].timeIntervalSince1970];
    }
    
    NSArray   *startArray = [self.startDay componentsSeparatedByString:@"-"];
    NSArray   *endArray   = [self.endDay componentsSeparatedByString:@"-"];
    NSInteger totalmonth       = ([endArray[0] integerValue] - [startArray[0] integerValue])* 12 + ([endArray[1] integerValue] - [startArray[1] integerValue]) + 1;
    
    for (int i = 0; i < totalmonth; i++) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [self.dataSource addObject:array];
    }
    
    NSInteger startYear = [startArray[0] integerValue];
    NSInteger startMonth = [startArray[1] integerValue];
    
    //第一年有几个月
    NSInteger baseMonth = 12 - startMonth + 1;
//    NSInteger startYear = [startArray[0] integerValue];
    for (int i = 0; i < totalmonth; i++) {
       
        NSDateComponents *components = [[NSDateComponents alloc]init];
        
        //获取下个月的年月日信息,并将其转为date
        NSInteger year;
        if ((i+1) <= baseMonth) {
            year = startYear;
        }else{
            year = startYear + (((i+1) - baseMonth)/13 + 1);
        }
        components.year  = year;
        
        int month = ((int)[NSDate month:self.startDay] + i)%12;
        components.month = month ? month : 12;

        components.day   = 1;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate     *nextDate = [calendar dateFromComponents:components];
        
        //获取该月第一天星期几
        NSInteger firstDayInThisMounth = [NSDate firstWeekdayInThisMonth:nextDate];
        
        //该月的有多少天daysInThisMounth
        NSInteger daysInThisMounth = [NSDate totaldaysInMonth:nextDate];
        NSString  *string          = [[NSString alloc]init];
        for (int j = 0; j < (daysInThisMounth > 29 && (firstDayInThisMounth == 6 || firstDayInThisMounth == 5) ? 42 : 35); j++) {
            CalenderModel *model = [[CalenderModel alloc] init];
            model.year  = components.year;
            model.month = components.month;
            if (j < firstDayInThisMounth || j > daysInThisMounth + firstDayInThisMounth - 1) {
                string    = @"";
                model.day = string;
            } else {
                string    = [NSString stringWithFormat:@"%ld", j - firstDayInThisMounth + 1];
                model.day = string;
                
                NSString *dateStr = [NSString stringWithFormat:@"%zd-%02zd-%@",model.year, model.month, model.day];
                if ([self isActivity:dateStr]) {
                    model.activityColor = [UIColor blackColor];
                }
                if (self.selectedDate.length) {
                    if ([NSDate isEqualBetweenWithDate:self.selectedDate toDate:dateStr]) {
                        model.isSelected = YES;
                        self.lastIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    }
                    if ([NSDate isToday:dateStr]) {
                        model.isToday = YES;
                    }
                }else{
                    if ([NSDate isToday:dateStr]) {
                        model.isToday = YES;
//                        model.isSelected = YES;
//                        self.lastIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    }
                }
            }
            [[self.dataSource objectAtIndex:i]addObject:model];
        }
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.dataSource objectAtIndex:section] count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
    if (self.isSingleChoose) {
        [self refreshSingleClickView:indexPath];
    }else{
         [self refreshDoubleClickView:indexPath];
    }
    
    
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalenderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CalenderModel *model = self.dataSource[indexPath.section][indexPath.item];
    if(indexPath.row%7 == 0 || indexPath.row%7 == 6){
        model.isWeekend = YES;
    }else{
        model.isWeekend = NO;
    }
    cell.model = model;

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CalenderHeaderView *heardView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        CalenderModel      *model     = self.dataSource[indexPath.section][indexPath.item];
        heardView.yearAndMonthLabel.text = [NSString stringWithFormat:self.yearMonthFormat.length ? self.yearMonthFormat : @"%zd年%zd月", model.year, model.month];
        NSString *dateStr = [NSString stringWithFormat:@"%zd-%02zd",model.year, model.month];
        heardView.yearAndMonthLabel.textColor = [UIColor blackColor];
        heardView.backgroundColor = [UIColor lightGrayColor];
        return heardView;
    }
    
    return nil;
}


#pragma mark - set
-(void)setActvityColor:(BOOL)actvityColor {
    [self.dataSource removeAllObjects];
    [self buildSource];
    [self.collectionView reloadData];
}

- (void)setWeekBottomLineColor:(UIColor *)weekBottomLineColor {
    _weekBottomLineColor = weekBottomLineColor;
    self.weekView.weekBottomLineColor = weekBottomLineColor;
}


-(void)setShowWeekBottomLine:(BOOL)showWeekBottomLine {
    _showWeekBottomLine = showWeekBottomLine;
    self.weekView.showLine = showWeekBottomLine;
}

- (BOOL)isActivity:(NSString *)date {
    BOOL activity = NO;
    
    NSTimeInterval startInterval = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", self.startDay]];
    NSTimeInterval endInterval = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", self.endDay]];
    NSTimeInterval currentInterval = [NSDate timeIntervalFromDateString:[NSString stringWithFormat:@"%@ 00:00:00", date]];
    if (currentInterval >= startInterval && currentInterval <= endInterval) {
        activity = YES;
    }
    return activity;
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        float                      cellw       = self.bounds.size.width/7;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setHeaderReferenceSize:CGSizeMake(self.frame.size.width, 50)];
        flowLayout.sectionInset            = UIEdgeInsetsMake(0, -1, 0, 0);
        flowLayout.minimumInteritemSpacing = -1;
        flowLayout.minimumLineSpacing      = 0;
        flowLayout.itemSize                = CGSizeMake(cellw, 50);
        
        CGFloat collectionViewY = CGRectGetMaxY(self.weekView.frame);
        CGFloat collectionViewH = self.frame.size.height - collectionViewY;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionViewY, self.frame.size.width, collectionViewH)  collectionViewLayout:flowLayout];
        
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        _collectionView.showsVerticalScrollIndicator   = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[CalenderHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        [_collectionView registerClass:[CalenderCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (CalenderWeekView *)weekView {
    if (_weekView == nil) {
        _weekView = [[CalenderWeekView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 32)];
        _weekView.backgroundColor = [UIColor lightGrayColor];
        _weekView.dataSource = self.weekArray ? self.weekArray : @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    }
    return _weekView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}




-(void)refreshSingleClickView:(NSIndexPath *)indexPath{
    CalenderModel *model = self.dataSource[indexPath.section][indexPath.item];
    if (!model.day.length) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(calenderView:dateString:)]) {
        [self.delegate calenderView:indexPath dateString:[NSString stringWithFormat:@"%zd-%zd-%@", model.year, model.month, model.day]];
    }
    if (indexPath == self.lastIndexPath) {
        return;
    }
    
    if (self.lastIndexPath) {
        CalenderModel *lastModel = self.dataSource[self.lastIndexPath.section][self.lastIndexPath.item];
        lastModel.isSelected  = !lastModel.isSelected;
        self.dataSource[self.lastIndexPath.section][self.lastIndexPath.item] = lastModel;
    }
    
    model.isSelected                                   = !model.isSelected;
    self.dataSource[indexPath.section][indexPath.item] = model;
    self.lastIndexPath                                 = indexPath;
    [self.collectionView reloadData];
}

-(void)refreshDoubleClickView:(NSIndexPath *)indexPath{
    CalenderModel *currentModel = self.dataSource[indexPath.section][indexPath.item];
    
    if (!currentModel.day.length) {
        return;
    }
    if (!self.startIndexPath) {
        //没有起点 当前点为起点
        self.startIndexPath = indexPath;
    }else{
        //存在起点
        if (!self.endIndexPath) {
            //没有终点
            //比较日期大小
            if (self.startIndexPath ==  indexPath){
                //当前日期 == 起点 无需改变
                return;
            }else{
                CalenderModel *lastStartModel = self.dataSource[self.startIndexPath.section][self.startIndexPath.item];
                if (![self isCurrentDay:currentModel largerThanDay:lastStartModel]) {
                    //如果当前点 小于起点 设为起点
                    self.startIndexPath = indexPath;
                    lastStartModel.isSelected = NO;
                }else{
                    //当前点 大于起点 设为终点
                    self.endIndexPath = indexPath;
                    //将两个日期之间所有的日期修改为被包含状态
                    [self changeStateToIncluedState:YES WithStartDay:self.startIndexPath withEndDay:self.endIndexPath];
                    [self returnBackDateWithStartModel:lastStartModel withEndModel:currentModel];
                }
            }
        }else{
            //有终点 清空起点及终点 将当前点设为起点
             CalenderModel *lastStartModel = self.dataSource[self.startIndexPath.section][self.startIndexPath.item];
             CalenderModel *lastEndModel = self.dataSource[self.endIndexPath.section][self.endIndexPath.item];
            lastStartModel.isSelected = NO;
            lastEndModel.isSelected = NO;
            //将两个日期之间所有的日期修改为被正常状态
            [self changeStateToIncluedState:NO WithStartDay:self.startIndexPath withEndDay:self.endIndexPath];
            self.startIndexPath = indexPath;
            self.endIndexPath = nil;
        }
    }
    
    currentModel.isSelected = YES;
    [self.collectionView reloadData];
    
    
}


-(void)changeStateToIncluedState:(BOOL)state WithStartDay:(NSIndexPath *)statrIndexPath withEndDay:(NSIndexPath *)endIndexPath{
    for (NSInteger i = statrIndexPath.section; i<=endIndexPath.section; i++) {
        NSArray *array = self.dataSource[i];
        NSInteger startPoint = 0;
        NSInteger endPoint = array.count-1;
        if (i == statrIndexPath.section) {
            startPoint = statrIndexPath.item+1;
        }
        if (i == endIndexPath.section) {
            endPoint = endIndexPath.item-1;
        }
        
        for (NSInteger j = startPoint; j<=endPoint; j++) {
            CalenderModel *model = array[j];
            model.isIncluded = state;
        }
    }
    
    
}

//比较日期大小
-(BOOL)isCurrentDay:(CalenderModel *)currentModel largerThanDay:(CalenderModel *)targetModel{
    if (currentModel.year > targetModel.year) {
        return YES;
    }else if (currentModel.year == targetModel.year){
        if (currentModel.month > targetModel.month) {
            return YES;
        }else if (currentModel.month == targetModel.month){
            NSInteger currentDay = [currentModel.day integerValue];
            NSInteger targetDay = [targetModel.day integerValue];
            if (currentDay > targetDay) {
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

//返回数据
-(void)returnBackDateWithStartModel:(CalenderModel *)statrModel withEndModel:(CalenderModel *)endModel{
    NSString *startMonth = [NSString stringWithFormat:@"%zd",statrModel.month];
    if (startMonth.length == 1) {
        startMonth = [NSString stringWithFormat:@"0%@",startMonth];
    }
    NSString *startDay = statrModel.day;
    if (startDay.length == 1) {
        startDay = [NSString stringWithFormat:@"0%@",startDay];
    }
    NSString *endMonth = [NSString stringWithFormat:@"%zd",endModel.month];
    if (endMonth.length == 1) {
        endMonth = [NSString stringWithFormat:@"0%@",endMonth];
    }
    NSString *endDay = endModel.day;
    if (endDay.length == 1) {
        endDay = [NSString stringWithFormat:@"0%@",endDay];
    }
    
    NSString *startDate = [NSString stringWithFormat:@"%ld-%@-%@",(long)statrModel.year,startMonth,startDay];
    NSString *endDate = [NSString stringWithFormat:@"%ld-%@-%@",(long)endModel.year,endMonth,endDay];
    
    
    if ([self.delegate respondsToSelector:@selector(calenderStartDay:endDay:)]) {
        [self.delegate calenderStartDay:startDate endDay:endDate];
    }
}

-(void)setIsSingleChoose:(BOOL)isSingleChoose{
    _isSingleChoose = isSingleChoose;
}
@end

