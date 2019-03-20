//
//  YKKZNetModel.h
//  iOSProject
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKHttpModel.h"

@interface YKKZNetModel : YKHttpModel
/**  获取热门小说*/
- (void)requestGetHotNovel:(callBackWithArray)callback;
@end
