//
//  YKKZNetModel.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKKZNetModel.h"

@implementation YKKZNetModel
- (void)requestGetHotNovel:(callBackWithArray)callback{
    [YKHttp getRequestWithURLStr:@"https://www.apiopen.top/novelApi" params:nil success:^(NSDictionary *responseDic) {
        if (![YKHelper isNull:responseDic]) {
            if ([responseDic[@"code"] integerValue] == 300) {
                [YKAlter makeTost:@"请求失败" View:self.fatherView];
            }else{
                NSArray *obj = responseDic[@"data"];
                if(callback)  callback(obj);
            }
        }

    } failure:^(NSError *error) {
        
    }];
}
@end
