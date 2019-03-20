//
//  YKTodayTableViewCell.m
//  YKToday
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKTodayTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation YKTodayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(YKKZModel *)model{
    [self.book_cover sd_setImageWithURL:[NSURL URLWithString:model.book_cover] placeholderImage:[UIImage imageNamed:@"default"]];
    self.bookname.text = model.bookname;
    self.introduction.text = model.introduction;
    self.author_name.text = model.author_name;
}

@end
