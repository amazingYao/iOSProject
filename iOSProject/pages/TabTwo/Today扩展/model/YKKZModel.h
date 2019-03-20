//
//  YKKZModel.h
//  iOSProject
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKKZModel : NSObject
/** 小说名字*/
@property(nonatomic,copy) NSString *bookname;
/** 封面图片URL*/
@property(nonatomic,copy) NSString *book_cover;
/** 作者名字*/
@property(nonatomic,copy) NSString *author_name;

/** 简介*/
@property(nonatomic,copy) NSString *introduction;


@end
