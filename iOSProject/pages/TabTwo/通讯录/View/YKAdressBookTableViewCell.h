//
//  YKAdressBookTableViewCell.h
//  iOSProject
//
//  Created by 姚凯 on 2018/12/5.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJPerson.h"
NS_ASSUME_NONNULL_BEGIN

@interface YKAdressBookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (nonatomic, strong) LJPerson *model;
@end

NS_ASSUME_NONNULL_END
