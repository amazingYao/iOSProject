//
//  YKKZTableViewCell.m
//  iOSProject
//
//  Created by 姚凯 on 2018/11/27.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKKZTableViewCell.h"

@implementation YKKZTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(YKKZModel *)model{
    [YKHelper namedImageView:self.book_cover With:model.book_cover];
    self.bookname.text = model.bookname;
    self.introduction.text = model.introduction;
    self.author_name.text = model.author_name;
}
@end
