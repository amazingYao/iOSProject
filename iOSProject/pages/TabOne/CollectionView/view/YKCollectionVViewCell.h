//
//  YKCollectionVViewCell.h
//  iOSProject
//
//  Created by 姚凯 on 2018/11/29.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKCollectionVViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *tittleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTittleLab;

@end
