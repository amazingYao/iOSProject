//
//  YKHelper.h
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/** 成功回调方法 返回任意类型*/
typedef void(^succeedBack)(id object);
/** 失败回调方法 返回任意类型*/
typedef void(^failedBack)(id object);
typedef void(^imageBlock)(UIImage *image);

typedef void(^CtionBlock)(UIImage *image);
typedef enum
{
    image_type_all = 0,
    image_type_max,
    image_type_mid,
    image_type_min,
    
}ImageType;

@interface YKHelper : NSObject
/** 判断是否为空 */
+ (BOOL)isNull:(id)object;
/**
 *过滤为空的string
 */
+ (NSString *)returnStr:(id)object OrNilStr:(NSString *)str;
/**
 *label设置行间距
 */
+ (void)addLabel:(UILabel *)label ParagraphLineSpace:(CGFloat)paragraphLineSpace text:(NSString *)text;
/**
 *label根据内容设置尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW maxH:(CGFloat)maxH;

/**判断长度为0*/
+(BOOL)judgeLengthIsZeroWith:(NSString *)text;

#pragma mark - NSString、NSArrray、NSDictionary 一些互转方法
+ (NSArray *)JSONStringToNSArrray:(NSString *)str;
+ (NSDictionary *)JSONStringToNSDictionary:(NSString *)str;
+ (NSString *)ObjectToNSString:(id)object;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

#pragma mark - 时间方法
+ (NSString *)dateFrommatChange:(NSString *)str;
+ (NSString *)DateToString:(NSString *)dateStr;
+ (NSDate *)getOneDayByInterval:(NSInteger)interval fromDate:(NSDate *)smDate;
+(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate;
+ (NSString *)rangeDate:(NSString *)date;
+ (NSDate *)changeNSStringToDate:(NSString *)dateStr;
+ (NSString *)getNowDate;
+ (NSString *)changeDateToNSString:(NSDate *)date;
+ (NSString *)changeDateToNSString1:(NSDate *)date;
+ (NSString *)rangeMonthAndDya:(NSString *)date;

+ (NSDate *)changeNSStringToDate2:(NSString *)dateStr;

+ (NSString *)getWeekFromDateStr:(NSString *)dateStr;

+ (NSString *)getWeekFromDate:(NSDate *)sender;
+ (NSString *)getTommowerDate:(NSDate *)sender;




/**
 *  截取月-日
 *
 *  @param dateStr 时间字符串
 *
 *  @return 月日
 */
+ (NSString *)rangeMonthAndDayFormat:(NSString *)dateStr;



/**
 *  截取年月日
 *
 *
 */
+ (NSString *)rangeYearMonthDay:(NSString *)dateStr;
+ (NSString *)rangeHourAndMintue:(NSString *)dateStr;


+ (void )namedButtonProgress:(UIButton *)button With:(NSString *)name WithImageType:(ImageType)type WithPlaceimage:(NSString *)placePath complete:(CtionBlock)completedBlock;
#pragma mark - 给图片赋值
+ (void )namedImageView:(UIImageView *)imageV With:(NSString *)name andPlaceImage:(NSString *)placePath;
+ (void )namedButton:(UIButton *)button With:(NSString *)name andPlaceImage:(NSString *)placePath;
+ (void )namedImageView:(UIImageView *)imageV With:(NSString *)name;
+ (void )namedButton:(UIButton *)button With:(NSString *)name;
+ (void )namedButtonBgIm:(UIButton *)button With:(NSString *)name WithImageType:(ImageType)type WithPlaceimage:(NSString *)placePath;
+ (void )namedButton1:(UIButton *)button With:(NSString *)name Block:(imageBlock)block;
/**
 * UIImage 根据图片不同规格设置不同尺寸的图片
 */
+ (void )namedImageView:(UIImageView *)imageV With:(NSString *)name WithImageType:(ImageType)type WithPlaceimage:(NSString *)placePath;
/**
 * UIButton 根据图片不同规格设置不同尺寸的图片
 */
+ (void )namedButton:(UIButton *)button With:(NSString *)name WithImageType:(ImageType)type WithPlaceimage:(NSString *)placePath;

/** 取一个颜色值作为背景图 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/** 压缩图片 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

#pragma mark - 对get请求的url和参数进行拼接
+ (NSString *)appdendingGetPostURLWithPath:(NSString *)url andParam:(NSDictionary *)param;
/** 把颜色值转换成UIImage对象 */
+(UIImage*) createImageWithColor:(UIColor*) color;

#pragma mark - 归档和解档
+ (void)savePlistWithObject:(id)object fileName:(NSString *)keyName;
+ (id)readPlistWithObjetct:(id)object fileName:(NSString *)keyName;

#pragma mark - 设置TextField内边距
+ (void)setTextFieldPadding:(UITextField *)textField forLeftWidth:(CGFloat)leftWidth andRightWidth:(CGFloat)rightWidth;


#pragma mark - 判断方法
+ (BOOL)isNumText:(NSString *)str;
+ (BOOL)isMobileNum:(NSString *)num;

#pragma mark - 拨打电话
/**拨打电话*/
+ (void)callPhone:(NSString *)phone;


/** 弹出alertview */
+ (void)showAlertViewWithMsg:(NSString *)str;

#pragma mark - 获得缓存和清理缓存
/** 清除缓存 */
+ (void)cleanCachesWithSucceedBlock:(succeedBack)complete;

+ (BOOL)checkMailInput:(NSString *)mail;



@end
