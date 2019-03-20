//
//  YKLBCustomCell.m
//  iOSProject
//
//  Created by 姚凯 on 2018/12/3.
//  Copyright © 2018 姚凯. All rights reserved.
//

#import "YKLBCustomCell.h"

@implementation YKLBCustomCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithWhite:0.2f alpha: 0.5];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.equalTo(@(30));
    }];
    
    self.tittleLabel = [[UILabel alloc] init];
    self.tittleLabel.textAlignment = NSTextAlignmentLeft;
    self.tittleLabel.textColor = [UIColor redColor];
    self.tittleLabel.font = TextFont(15);
    [bottomView addSubview:self.tittleLabel];
    
    self.indexLabel = [[UILabel alloc] init];
    self.indexLabel.textAlignment = NSTextAlignmentRight;
    self.indexLabel.textColor = [UIColor redColor];
    self.indexLabel.font = TextFont(15);
    [bottomView addSubview:self.indexLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.right.offset(-10);
    }];
    
    [_tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.offset(0);
        make.right.equalTo(self->_indexLabel.mas_left).offset(0);
    }];
    
}
@end
