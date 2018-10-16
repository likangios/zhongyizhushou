//
//  SignInTaHWLLOCCbleViewCell.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/28.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "SignInTaHWLLOCCbleViewCell.h"


@implementation SignInTaHWLLOCCbleViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.signInButton];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(15);
        }];
        [self.signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(45);
        }];
    }
    return self;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UIButton *)signInButton{
    if (!_signInButton) {
        _signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signInButton.userInteractionEnabled = NO;
        [_signInButton setImage:[UIImage imageNamed:@"signed"] forState:UIControlStateNormal];
        [_signInButton setImage:[UIImage imageNamed:@"unsigned"] forState:UIControlStateDisabled];
    }
    return _signInButton;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
