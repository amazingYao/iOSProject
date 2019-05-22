//
//  YKImageMaskViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/4/28.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKImageMaskViewController.h"
#import "UIImage+WaterMark.h"
@interface YKImageMaskViewController ()

@property (nonatomic,strong) UIImageView *imageV;

@end

@implementation YKImageMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    [self titleIS:@"图片加水印"];
    NSArray *arr = @[@"文字水印",@"图片水印",@"文字+图片水印"];
    CGFloat width = SCREEN_WIDTH/3;
    for (int i = 0; i<arr.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font = TextFont(14);
        [button setTitleColor:RGB(150,145,169) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(NavBar_Height);
            make.width.equalTo(@(width));
            make.height.equalTo(@50);
            make.left.offset(width*i);
        }];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor redColor].CGColor;
        button.tag = i;
    }
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavBar_Height + 50);
    }];
    self.imageV = imageV;
    
    
}

-(void)addImage:(UIButton *)button{
    switch (button.tag) {
        case 0:
            [self addTextMask];
            break;
        case 1:
            [self addImageMask];
            break;
        case 2:
            [self addTextAndImageMask];
            break;
        default:
            break;
    }
}

//文字水印
-(void)addTextMask{
    UIImage *baseImage = [UIImage imageNamed:@"image1"];
    
    NSString *str = @"一我是水印一我是水印一";
    NSDictionary *attribute = @{NSFontAttributeName:TextFont(15) ,NSForegroundColorAttributeName:[UIColor lightGrayColor],NSBackgroundColorAttributeName:[UIColor whiteColor]};
    CGSize baseSize = CGSizeMake(500, CGFLOAT_MAX);
    CGSize strSize  = [str
                         boundingRectWithSize:baseSize
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:TextFont(15)}
                         context:nil].size;
    
    NSString *strTwo = @"一我还是是水印一我还是水印一";
    NSDictionary *attributeTwo = @{NSFontAttributeName:TextFont(20) ,NSForegroundColorAttributeName:[UIColor lightGrayColor],NSBackgroundColorAttributeName:[UIColor whiteColor]};
    CGSize strTwoSize  = [strTwo
                       boundingRectWithSize:baseSize
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName:TextFont(20)}
                       context:nil].size;
   
    CGPoint point = CGPointMake(baseImage.size.width-strSize.width, baseImage.size.height-strSize.height-strTwoSize.height);
    UIImage *resultImage = [baseImage imageWaterMarkWithString:str point:point attribute:attribute];
    
    CGPoint pointTwo = CGPointMake(baseImage.size.width-strTwoSize.width, baseImage.size.height-strTwoSize.height);
    UIImage *resultImageTwo = [resultImage imageWaterMarkWithString:strTwo point:pointTwo attribute:attributeTwo];
    
    self.imageV.image = resultImageTwo;
    
    
    
}

//图片水印
-(void)addImageMask{
    UIImage *baseImage = [UIImage imageNamed:@"image1"];
    UIImage *maskImage = [UIImage imageNamed:@"publish"];
    
//    CGRect rect = CGRectMake(0, 0, 50, 50);
//    UIImage *resultImage = [baseImage imageWaterMarkWithImage:maskImage imageRect:rect alpha:0.5];
    
    CGPoint point = CGPointMake(0, 0);
    UIImage *resultImage = [baseImage imageWaterMarkWithImage:maskImage imagePoint:point alpha:0.5];
   
    self.imageV.image = resultImage;
}

//文字+图片水印
-(void)addTextAndImageMask{
    UIImage *baseImage = [UIImage imageNamed:@"image1"];
    UIImage *maskImage = [UIImage imageNamed:@"publish"];
    NSString *str = @"一我是水印一我是水印一";
    NSDictionary *attribute = @{NSFontAttributeName:TextFont(15) ,NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor redColor]};
    
    CGSize baseSize = CGSizeMake(500, CGFLOAT_MAX);
    CGSize strSize  = [str
                         boundingRectWithSize:baseSize
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:TextFont(15)}
                         context:nil].size;
  
    CGRect strRect = CGRectMake(baseImage.size.width-strSize.width, baseImage.size.height-strSize.height, strSize.width,strSize.height);
  
    CGRect imageRect = CGRectMake(baseImage.size.width-strSize.width-strSize.height, baseImage.size.height-strSize.height, strSize.height, strSize.height);

    UIImage *resultImage = [baseImage imageWaterMarkWithString:str rect:strRect attribute:attribute image:maskImage imageRect:imageRect alpha:0.5];
    self.imageV.image = resultImage;
    
}

@end
