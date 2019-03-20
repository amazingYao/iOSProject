//
//  YKKZTableViewCell.h
//  iOSProject
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKKZModel.h"
@interface YKKZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *book_cover;
@property (weak, nonatomic) IBOutlet UILabel *bookname;
@property (weak, nonatomic) IBOutlet UILabel *introduction;
@property (weak, nonatomic) IBOutlet UILabel *author_name;

@property (nonatomic,strong) YKKZModel *model;

@end
