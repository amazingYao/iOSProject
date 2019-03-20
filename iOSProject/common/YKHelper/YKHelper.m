//
//  YKHelper
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "YKHelper.h"
@implementation YKHelper
+ (NSString *)returnStr:(id)object OrNilStr:(NSString *)str
{
    if([object isKindOfClass:[NSNull class]] || object == nil)
    {
        return str;
    }else
    {
        return [NSString stringWithFormat:@"%@",object];
    }
}
/** 判断是否为空 */
+ (BOOL)isNull:(id)object
{
    if([object isKindOfClass:[NSNull class]] || object == nil)
    {
        return YES;
    }else
    {
        return NO;
    }
}

+ (void)addLabel:(UILabel *)label ParagraphLineSpace:(CGFloat)paragraphLineSpace text:(NSString *)text
{
    if(text.length == 0)
    {
        return;
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle*sty = [[NSMutableParagraphStyle alloc]init];
    sty.lineSpacing = paragraphLineSpace;
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:sty range:NSMakeRange(0, text.length)];
    
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, text.length)];
    
    label.attributedText = attributedStr;
}

+ (BOOL)isMobileNum:(NSString *)num
{
    NSString *mobile = [num stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        NSString *CT_NUM = @"^1[3-9][0-9]{9}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch = [pred evaluateWithObject:mobile];
        return isMatch;
    }
}



/**
 *  判断是否为数字
 *
 */
+ (BOOL)isNumText:(NSString *)str
{
    
    NSScanner* scan = [NSScanner scannerWithString:str];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

/**判断长度为0*/
+(BOOL)judgeLengthIsZeroWith:(NSString *)text
{
    if([self returnStr:text OrNilStr:@""].length == 0)
    {
        return YES;
    }else
    {
        return NO;
    }
}

#pragma  mark - label根据内容设置尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW maxH:(CGFloat)maxH
{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, maxH);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - 给图片赋值
+ (void )namedImageView:(UIImageView *)imageV With:(NSString *)name
{
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        imageV.image = [UIImage imageNamed:@"default"];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"]];
            
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,[self returnStr:name OrNilStr:@""]];
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"]];
        }
        
    }else
    {
        imageV.image = [UIImage imageNamed:[self returnStr:name OrNilStr:@""]];
    }
}

+ (void )namedImageView:(UIImageView *)imageV With:(NSString *)name andPlaceImage:(NSString *)placePath
{
    
    
    UIImage *placeImage = [[UIImage alloc] init];
    if(placePath.length == 0 || placePath == nil)
    {
        placePath = @"default";
    }else{
        placeImage = [UIImage imageNamed:placePath];
    }
    
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        imageV.image = [UIImage imageNamed:placePath];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeImage];
        }else
        {
            
            
        }
        
    }else
    {
        imageV.image = [UIImage imageNamed:[self returnStr:name OrNilStr:@""]];
    }
    
}

+ (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

+ (void )namedButton:(UIButton *)button With:(NSString *)name andPlaceImage:(NSString *)placePath
{
    if(placePath.length == 0 || placePath == nil)
    {
        placePath = @"default";
    }
    
    
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        [button setImage:[UIImage imageNamed:placePath] forState:UIControlStateNormal];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placePath]];
            
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placePath]];
        }
        
    }else
    {
        [button setImage:[UIImage imageNamed:[self returnStr:name OrNilStr:@""]] forState:UIControlStateNormal];
    }
}


+ (void )namedButton:(UIButton *)button With:(NSString *)name
{
    
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        [button setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
            
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
        }
        
    }else
    {
        [button setImage:[UIImage imageNamed:[self returnStr:name OrNilStr:@""]] forState:UIControlStateNormal];
    }
}
+ (void )namedButton1:(UIButton *)button With:(NSString *)name Block:(imageBlock)block
{
    
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        [button setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                block(image);
            }];
            
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                block(image);
            }];
        }
        
    }else
    {
        [button setImage:[UIImage imageNamed:[self returnStr:name OrNilStr:@""]] forState:UIControlStateNormal];
    }
}
/**
 * UIImage 根据图片不同规格设置不同尺寸的图片
 */
+ (void )namedImageView:(UIImageView *)imageV With:(NSString *)name WithImageType:(ImageType)type WithPlaceimage:(NSString *)placePath
{
    if(placePath.length == 0 || placePath == nil)
    {
        placePath = @"default";
    }
    imageV.contentMode = UIViewContentModeScaleToFill;
    if([[self returnStr:name OrNilStr:@""] length] > 0 && [[self returnStr:name OrNilStr:@""] containsString:@"all"])
    {
        
        switch (type)
        {
            case image_type_max:
                name = [name stringByReplacingOccurrencesOfString:@"max" withString:@"all"];
                break;
            case image_type_mid:
                name = [name stringByReplacingOccurrencesOfString:@"mid" withString:@"all"];
                break;
            case image_type_min:
                name = [name stringByReplacingOccurrencesOfString:@"min" withString:@"all"];
                break;
            default:
                break;
        }
    }
    
    
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        
        
        imageV.image = [UIImage imageNamed:placePath];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placePath]];
            
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,[self returnStr:name OrNilStr:@""]];
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placePath]];
        }
        
    }else
    {
        imageV.image = [UIImage imageNamed:[self returnStr:name OrNilStr:@""]];
    }
}
/**
 * UIButton 根据图片不同规格设置不同尺寸的图片
 */
+ (void )namedButton:(UIButton *)button With:(NSString *)name WithImageType:(ImageType)type WithPlaceimage:(NSString *)placePath
{
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    if(placePath.length == 0 || placePath == nil)
    {
        placePath = @"default";
    }
    
    if(name.length > 0 && [[self returnStr:name OrNilStr:@""] containsString:@"all"])
    {
        
        switch (type)
        {
            case image_type_max:
                name = [name stringByReplacingOccurrencesOfString:@"max" withString:@"all"];
                break;
            case image_type_mid:
                name = [name stringByReplacingOccurrencesOfString:@"mid" withString:@"all"];
                break;
            case image_type_min:
                name = [name stringByReplacingOccurrencesOfString:@"min" withString:@"all"];
                break;
            default:
                break;
        }
    }
    
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        [button setImage:[UIImage imageNamed:placePath] forState:UIControlStateNormal];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placePath]];
            
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placePath]];
        }
        
    }else
    {
        [button setImage:[UIImage imageNamed:[self returnStr:name OrNilStr:@""]] forState:UIControlStateNormal];
    }
}


+ (void )namedButtonProgress:(UIButton *)button With:(NSString *)name WithImageType:(ImageType)type WithPlaceimage:(NSString *)placePath complete:(CtionBlock)completedBlock
{
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    if(placePath.length == 0 || placePath == nil)
    {
        placePath = @"default";
    }
    
    if(name.length > 0 && [[self returnStr:name OrNilStr:@""] containsString:@"all"])
    {
        
        switch (type)
        {
            case image_type_max:
                name = [name stringByReplacingOccurrencesOfString:@"max" withString:@"all"];
                break;
            case image_type_mid:
                name = [name stringByReplacingOccurrencesOfString:@"mid" withString:@"all"];
                break;
            case image_type_min:
                name = [name stringByReplacingOccurrencesOfString:@"min" withString:@"all"];
                break;
            default:
                break;
        }
    }
    
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        [button setImage:[UIImage imageNamed:placePath] forState:UIControlStateNormal];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                completedBlock(image);
            }];
            
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placePath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                completedBlock(image);
            }];
        }
        
    }else
    {
        [button setImage:[UIImage imageNamed:[self returnStr:name OrNilStr:@""]] forState:UIControlStateNormal];
    }
}


/**
 * UIButton 根据图片不同规格设置不同尺寸的图片
 */
+ (void )namedButtonBgIm:(UIButton *)button With:(NSString *)name WithImageType:(ImageType)type WithPlaceimage:(NSString *)placePath
{
    
    
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    if(placePath.length == 0 || placePath == nil)
    {
        placePath = @"default";
    }
    
    if(name.length > 0 && [[self returnStr:name OrNilStr:@""] containsString:@"all"])
    {
        
        switch (type)
        {
            case image_type_max:
                name = [name stringByReplacingOccurrencesOfString:@"max" withString:@"all"];
                break;
            case image_type_mid:
                name = [name stringByReplacingOccurrencesOfString:@"mid" withString:@"all"];
                break;
            case image_type_min:
                name = [name stringByReplacingOccurrencesOfString:@"min" withString:@"all"];
                break;
            default:
                break;
        }
    }
    
    if([self returnStr:name OrNilStr:@""].length == 0)
    {
        [button setImage:[UIImage imageNamed:placePath] forState:UIControlStateNormal];
    }else if([[self returnStr:name OrNilStr:@""] containsString:@"/"])
    {
        if([[self returnStr:name OrNilStr:@""] containsString:@"http"])
        {
            NSString *url = [NSString stringWithFormat:@"%@",[self returnStr:name OrNilStr:@""]];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placePath]];
            
        }else
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,[self returnStr:name OrNilStr:@""]];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placePath]];
        }
        
    }else
    {
        [button setImage:[UIImage imageNamed:[self returnStr:name OrNilStr:@""]] forState:UIControlStateNormal];
    }
}


#pragma mark - NSString、NSArrray、NSDictionary 一些互转方法
/**
 *  NSString 转 NSArrray
 */
+ (NSArray *)JSONStringToNSArrray:(NSString *)str
{
    NSString *infoStr = str ;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[infoStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    return arr;
}
/**
 *  NSString 转 NSDictionary
 */
+ (NSDictionary *)JSONStringToNSDictionary:(NSString *)str
{
    NSString *infoStr = str ;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[infoStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    return dic;
}
/**
 *   NSDictionary NSArrray 转 NSString
 */
+ (NSString *)ObjectToNSString:(id)object
{
    NSError *parseError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *query = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return query;
}

/**字典转成Json字符串*/
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - 时间的一些转换方法
/**
 *   时间戳转换成时间
 */
+ (NSString *)dateFrommatChange:(NSString *)str
{
    if([self returnStr:str OrNilStr:@""].length > 10)
    {
        NSRange range;
        range.location=6;
        range.length=13;
        NSString *date=[str substringWithRange:range];
        
        NSDateFormatter *objDateFormat=[[NSDateFormatter alloc] init];
        [objDateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSTimeInterval timeInterval=[date doubleValue]/1000.0;
        NSDate *date2=[NSDate dateWithTimeIntervalSince1970:timeInterval];
        
        NSString *returnStr=[objDateFormat stringFromDate:date2];
        return returnStr;
    }else
    {
        return [self returnStr:str OrNilStr:@""];
    }
}


/*
 *时间转时间戳 仅限 XXXX-XX-XX格式
 */
+ (NSString *)DateToString:(NSString *)dateStr
{
    NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    
    //    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    //    NSString *nowtimeStr = [formatter stringFromDate:date];//----------将nsdate按formatter格式转成nsstring
    // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    
    return timeSp;
}

/**
 *  得到从某天起（NDate类型）相隔X天的日期
 *
 *  @param interval 相隔多少天
 *  @param smDate   从某天起
 *
 *  @return 最终日期(NSDate类型)
 */
+ (NSDate *)getOneDayByInterval:(NSInteger)interval fromDate:(NSDate *)smDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:smDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setDay:interval];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:smDate options:0];
    return newdate;
}

/**
 *  得到两个日期的天数差
 *
 *  @param serverDate 开始日期
 *  @param endDate    结束日期
 *
 *  @return 相差天数
 */
+(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}


/**
 *  截取时间 2016-10-28 10:36:31 只要年月日 2016-10-28
 */
+ (NSString *)rangeDate:(NSString *)date
{
    
    if([self returnStr:date OrNilStr:@""].length > 10)
    {
        NSRange range;
        range.location = 0;
        range.length = 10;
        NSString *str = [date substringWithRange:range];
        return str;
    }else
    {
        return [self returnStr:date OrNilStr:@""];
    }
    
}


/**
 *  时间NSString转NDate 传入时间如：2016-10-28 10:37:14
 *
 */
+ (NSDate *)changeNSStringToDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    return date;
}


/**
 *  时间NSString转NDate 传入时间如：2016-10-28
 *
 */
+ (NSDate *)changeNSStringToDate2:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    return date;
}


/**
 *  得到当前时间 如：2016-10-28 10:37:14
 *
 */
+ (NSString *)getNowDate
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [fm stringFromDate:now];
}

/**
 *  NSDate 转换成 NSString  返回如:2016-10-28
 *
 */
+ (NSString *)changeDateToNSString:(NSDate *)date
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy-MM-dd"];
    return [fm stringFromDate:date];
}

+ (NSString *)changeDateToNSString1:(NSDate *)date
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy-MM-dd HH"];
    return [fm stringFromDate:date];
}

/**
 *  时间NSString 2016-10-28 10:39:12 截取出 如 10-28格式字符串
 *
 */
+ (NSString *)rangeMonthAndDya:(NSString *)date
{
    
    if([self returnStr:date OrNilStr:@""].length >= 10)
    {
        NSRange range;
        range.location = 5;
        range.length = 5;
        NSString *str = [date substringWithRange:range];
        return str;
    }else
    {
        return [self returnStr:date OrNilStr:@""];
    }
    
}

/**
 *  年月日 2016-10-28 10:40:22 得到 星期几
 *
 *  @param dateString <#dateStr description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)getWeekFromDateStr:(NSString *)dateString
{
    NSDate *sender ;
    
    if([self returnStr:dateString OrNilStr:@""].length  > 10)
    {
        sender = [self changeNSStringToDate:dateString];
    }else if([self returnStr:dateString OrNilStr:@""].length  == 10)
    {
        sender = [self changeNSStringToDate2:dateString];
    }else
    {
        return  [self returnStr:dateString OrNilStr:@""];
    }
    NSDateFormatter *dateFommat = [[NSDateFormatter alloc] init];
    [dateFommat setDateFormat:@"EEEE"];
    NSString *dateStr= [dateFommat stringFromDate:sender];
    return dateStr;
    
}



/**
 *  NSDate 得到星期几
 *
 *  @param sender NSDate
 *
 *  @return 星期几
 */
+ (NSString *)getWeekFromDate:(NSDate *)sender
{
    NSDateFormatter *dateFommat = [[NSDateFormatter alloc] init];
    [dateFommat setDateFormat:@"EEEE"];
    NSString *dateStr= [dateFommat stringFromDate:sender];
    return dateStr;
    
}

/**
 *  NSDate 得到 明天 时间NSString 如：10-29
 *
 *  @param sender NSDate
 *
 *  @return 时间NSString 10-29
 */
+ (NSString *)getTommowerDate:(NSDate *)sender
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"MM-dd"];
    return [fm stringFromDate:sender];
}


/**
 *  截取月-日
 *
 *  @param dateStr 时间字符串
 *
 *  @return 月日
 */
+ (NSString *)rangeMonthAndDayFormat:(NSString *)dateStr
{
    if([self returnStr:dateStr OrNilStr:@""].length > 10)
    {
        NSRange yearRange;
        yearRange.location = 5;
        yearRange.length = 5;
        return [dateStr substringWithRange:yearRange];
        
    }else
    {
        return [self returnStr:dateStr OrNilStr:@""];
    }
}



/**
 *  截取年月日
 *
 *
 */
+ (NSString *)rangeYearMonthDay:(NSString *)dateStr
{
    
    if([self returnStr:dateStr OrNilStr:@""].length > 10)
    {
        NSRange range;
        range.location = 0;
        range.length = 10;
        NSString *str = [dateStr substringWithRange:range];
        return str;
    }else
    {
        return dateStr;
    }
    
}

+ (NSString *)rangeHourAndMintue:(NSString *)dateStr
{
    NSRange yearRange;
    yearRange.location = 11;
    yearRange.length = 5;
    
    return [dateStr substringWithRange:yearRange];
}





#pragma mark - 对get请求的url和参数进行拼接
+ (NSString *)appdendingGetPostURLWithPath:(NSString *)url andParam:(NSDictionary *)param
{
    NSString * str = @"";
    NSArray *array = param.allKeys;
    for(int i=0; i<array.count; i++)
    {
        NSString *key = array[i];
        NSString *value = param[key];
        if(i == array.count - 1)
        {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
        }else
        {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,value]];
        }
        
    }
    
    str = [NSString stringWithFormat:@"%@?%@",url,str];
    
    return str;
    
}


#pragma mark - 归档和解档
+ (void)savePlistWithObject:(id)object fileName:(NSString *)keyName
{
    
    //2.获取文件路径
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",keyName]];
    NSLog(@"path=%@",path);
    
    //3.将自定义的对象保存到文件中
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}

+ (id)readPlistWithObjetct:(id)object fileName:(NSString *)keyName
{
    
    //2.获取文件路径
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",keyName]];
    NSLog(@"path=%@",path);
    
    //2.从文件中读取对象
    object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return object;
}


#pragma mark - 设置TextField内边距
+ (void)setTextFieldPadding:(UITextField *)textField forLeftWidth:(CGFloat)leftWidth andRightWidth:(CGFloat)rightWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
    
    
    frame.size.width = rightWidth;
    UIView *rightview = [[UIView alloc] initWithFrame:frame];
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightView = rightview;
}

#pragma mark - 拨打电话
/**拨打电话*/
+ (void)callPhone:(NSString *)phone
{
    NSString *phoneStr = [NSString stringWithFormat:@"tel://%@",phone];
    //调用电话
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
}


#pragma mark - 图片压缩方法
//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    UIGraphicsEndImageContext();

    return     image;
}

/** 取一个颜色值作为背景图 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




#pragma mark - 提示
/** 弹出alertview */
+ (void)showAlertViewWithMsg:(NSString *)str
{
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertV show];
}

#pragma mark - 清理缓存
/** 清除缓存 */
+ (void)cleanCachesWithSucceedBlock:(succeedBack)complete
{
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        // 执行耗时的异步操作...
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程，执行UI刷新操作
            if(complete)
            {
                complete(nil);
            }
        });
    });
}


#pragma 正则匹配邮箱号
+ (BOOL)checkMailInput:(NSString *)mail{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:mail];
}



@end
