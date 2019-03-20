//
//  YKHttp.m
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import "YKHttp.h"


@implementation YKHttp
+ (void)postRequestWithURLStr:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary * responseDic))success failure:(void(^)(NSError* error))failure
{
    NSDictionary *param = [self getRequestParamsWithBizParams:params];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *res = [responseObject copy];
        if (![YKHelper isNull:res]) {
            NSDictionary *data = res[@"data"];
            if (![YKHelper isNull:data]) {
                NSDictionary *respParams = data[@"respParams"];
                if (![YKHelper isNull:respParams]) {
                    if (success) {
                        success(respParams);
                    }
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)getRequestWithURLStr:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary * responseDic))success failure:(void(^)(NSError* error))failure{
    NSDictionary *param = [self getRequestParamsWithBizParams:params];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 上传图片
+ (void)uploadImage:(UIImage *)successImage URL:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseDic))complete
{
    CGFloat imgWidth = successImage.size.width;
    CGFloat imgHieght = successImage.size.height;
    if(successImage.size.width > successImage.size.height)  //宽 > 高
    {
        if(imgWidth > 2000)
        {
            imgWidth = imgWidth/2;
            imgHieght = imgHieght/2;
        }
        
        if(imgWidth >= 1000)
        {
            imgWidth = imgWidth/2;
            imgHieght = imgHieght/2;
        }
        
        if(imgWidth >= 500)
        {
            imgWidth = imgWidth/2;
            imgHieght = imgHieght/2;
        }
    }else     //宽 < 高
    {
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
        
        if (imgHieght >= 750)
        {
            imgWidth = imgWidth/2;
            imgHieght = imgHieght/2;
        }
    }
    UIImage * compressImg = [YKHelper imageWithImageSimple:successImage scaledToSize:CGSizeMake(imgWidth, imgHieght)];
    NSLog(@"原本尺寸:(%f,%f)   裁剪尺寸:(%f,%f)",successImage.size.width,successImage.size.height,imgWidth,imgHieght);
    NSData *data;
    if(UIImagePNGRepresentation(compressImg) == nil)
    {
        data = UIImageJPEGRepresentation(compressImg, 1.0);
    }else
    {
        data = UIImagePNGRepresentation(compressImg);
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    AFSecurityPolicy*securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    NSString * cerPath = [[NSBundle mainBundle] pathForResource:BASECER ofType:@"cer"];
//    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//    NSSet  *dataSet = [NSSet setWithArray:@[cerData]];
//    
//    [securityPolicy setAllowInvalidCertificates:YES];
//    [securityPolicy setPinnedCertificates:dataSet];
//    [securityPolicy setValidatesDomainName:NO];
//    [manager setSecurityPolicy: securityPolicy];
    
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",str];
        
        [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        complete(jsonDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//获取基础参数 封装请求参数
+(NSDictionary *)getRequestParamsWithBizParams:(NSDictionary *)bizParams{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"bizParams"] = bizParams;
    NSMutableDictionary *baseParams = [[NSMutableDictionary alloc] init];
    baseParams[@"version"] = [YKSystem getCurrentVersion];
    baseParams[@"deviceType"] = [YKSystem getDeviceType];
    params[@"baseParams"] = baseParams;
    return params;
}

@end
