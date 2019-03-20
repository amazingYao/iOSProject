//
//  YKHttp.h
//  baseFramework
//
//  Created by 姚凯 on 2018/4/25.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKHttp : NSObject
/**
 *  post请求
 *
 *  @param urlStr   请求接口
 *  @param params   请求参数
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+ (void)postRequestWithURLStr:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary * responseDic))success failure:(void(^)(NSError* error))failure;

/**
 *  get请求
 *
 *  @param urlStr   请求接口
 *  @param params   请求参数
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+ (void)getRequestWithURLStr:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary * responseDic))success failure:(void(^)(NSError* error))failure;

/**
 *  上传图片
 */
+ (void)uploadImage:(UIImage *)successImage URL:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseDic))complete;
@end
