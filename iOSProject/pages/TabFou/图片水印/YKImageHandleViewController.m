//
//  YKImageHandleViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/5/13.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKImageHandleViewController.h"
#import "UIImage+WaterMark.h"
#import <AMapLocationKit/AMapLocationKit.h>
@interface YKImageHandleViewController ()<AMapLocationManagerDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) AMapLocationManager *locationManager;

@property (nonatomic,strong) NSString *currentAdress;
@end

@implementation YKImageHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getLocation];
}

-(void)initUI{
    [self titleIS:@"图片打水印"];
    [self setNavigationRightBarButtonWithString:@"拍照"];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT * 0.8));
        make.width.equalTo(@(SCREEN_WIDTH * 0.8));
    }];
    self.imageView = imageView;
}

-(void)rightBAction{
    [YKImagePicker showImagePickerFromViewController:self allowsEditing:NO finishAction:^(UIImage *image) {
          [self handleImage:image];
    }];

}



#pragma  mark - 图片处理
-(void)handleImage:(UIImage *)image{
    NSString *currentTimeString = [self getDate];
    UIImage *baseImage = [self getNewSizeWithImage:image];
    
    
    UIFont *font = TextFont(20);
    CGSize baseSize = CGSizeMake(baseImage.size.width, CGFLOAT_MAX);
    NSDictionary *attribute = @{NSFontAttributeName:font ,NSForegroundColorAttributeName:[UIColor darkTextColor]};
   

   
    CGSize strSize  = [currentTimeString
                       boundingRectWithSize:baseSize
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName:font}
                       context:nil].size;
    
    CGSize strTwoSize  = [self.currentAdress
                          boundingRectWithSize:baseSize
                          options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName:font}
                          context:nil].size;
    
    CGPoint point = CGPointMake(baseImage.size.width-strSize.width, baseImage.size.height-strSize.height-strTwoSize.height);
    CGPoint pointTwo = CGPointMake(baseImage.size.width-strTwoSize.width, baseImage.size.height-strTwoSize.height);
   
    UIImage *resultImage = [baseImage imageWaterMarkWithString:currentTimeString point:point attribute:attribute];
    UIImage *resultImageTwo = [resultImage imageWaterMarkWithString:self.currentAdress point:pointTwo attribute:attribute];
    self.imageView.image = resultImageTwo;
}

-(UIImage *)getNewSizeWithImage:(UIImage *)image{
    CGFloat imgWidth = image.size.width;
    CGFloat imgHieght = image.size.height;
    if(image.size.width > image.size.height){
        if(imgWidth > 2000){
            imgWidth = imgWidth/2;
            imgHieght = imgHieght/2;
        }
        if(imgWidth >= 1000)
        {
            imgWidth = imgWidth/2;
            imgHieght = imgHieght/2;
        }
    }else{
        if (imgHieght > 3000)
        {
            imgWidth = imgWidth/2;
            imgHieght = imgHieght/2;
        }
        if (imgHieght >= 1500)
        {
            imgWidth = imgWidth/2;
            imgHieght = imgHieght/2;
        }
    }
    UIImage *newImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(imgWidth, imgHieght)];
    return newImage;
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//获取时间
-(NSString *)getDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

//获取位置信息
-(void)getLocation{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    
     //持续定位
     self.locationManager = [[AMapLocationManager alloc] init];
     self.locationManager.delegate = self;
     self.locationManager.distanceFilter = 100;
     self.locationManager.locatingWithReGeocode = YES;
     //允许后台定位
     self.locationManager.allowsBackgroundLocationUpdates = YES;
     [self.locationManager startUpdatingLocation];
}
#pragma mark - delegate
//持续定位代理方法
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    self.currentAdress = reGeocode.formattedAddress;
}
@end
