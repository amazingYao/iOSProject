//
//  YKHttpModel.h
//  baseFramework
//
//  Created by 姚凯 on 2018/4/26.
//  Copyright © 2018年 姚凯. All rights reserved.
//

#import <Foundation/Foundation.h>
/**request请求成功回调方法 返回任意类型*/
//typedef void(^succeedBack)(id object);
/**request请求失败回调方法 返回任意类型*/
typedef void(^failedBack)(id object);


/**request请求回调方法 无返参*/
typedef void(^callBack)(void);

/**request请求回调方法 返回任意类型*/
typedef void(^callBackWithAnyObject)(id object);

/**request请求回调方法 返回字符串*/
typedef void(^callBackWithString)(NSString *string);

/**request请求回调方法 返回NS*/
typedef void(^callBackWithArray)(NSArray *array);

/**request请求回调方法 返回字典*/
typedef void(^callBackWithDictionary)(NSDictionary *dictionary);



@interface YKHttpModel : NSObject
/** 上一级视图 */
@property (nonatomic,strong)UIView *fatherView;
/**调用这个类的控制器*/
@property (nonatomic,strong)UIViewController *viewController;

@end
