//
//  HeadTHWLLOCCableViewCell.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/28.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "HeadTHWLLOCCableViewCell.h"

@implementation HeadTHWLLOCCableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.idLabel];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(45);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(10);
            make.bottom.equalTo(self.headImageView.mas_centerY).offset(-5);
        }];
        
        [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(10);
            make.top.equalTo(self.headImageView.mas_centerY).offset(5);
        }];
        
    }
    return self;
}
- (UIImageView *)headImageView{
    if(!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"head"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
- (UILabel *)idLabel{
    if (!_idLabel) {
        _idLabel = [UILabel new];
        _idLabel.font = [UIFont systemFontOfSize:12];
        _idLabel.textColor = [UIColor colorWithHexString:@"cccccc"];
        _idLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _idLabel;
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
