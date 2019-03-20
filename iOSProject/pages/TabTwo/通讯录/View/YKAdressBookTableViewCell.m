//
//  YKAdressBookTableViewCell.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/5.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKAdressBookTableViewCell.h"

@implementation YKAdressBookTableViewCell

- (void)setModel:(LJPerson *)model
{
    self.iconImageV.image = model.image ? model.image : [UIImage imageNamed:@"default"];
    self.nameLabel.text = model.fullName;
    LJPhone *phoneModel = model.phones.firstObject;
    self.phoneNumLabel.text = phoneModel.phone;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageV.layer.cornerRadius = 40/2;
    self.iconImageV.layer.masksToBounds = YES;
    self.iconImageV.layer.borderWidth = 0.01;
    self.iconImageV.layer.borderColor = kWhiteColor.CGColor;
}
@end
