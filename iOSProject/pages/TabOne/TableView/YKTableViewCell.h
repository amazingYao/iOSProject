//
//  YKTableViewCell.h
//  iOSProject
//
//  Created by 姚凯 on 2018/11/28.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgV;
@property (weak, nonatomic) IBOutlet UILabel *tittleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTittle;

@end
