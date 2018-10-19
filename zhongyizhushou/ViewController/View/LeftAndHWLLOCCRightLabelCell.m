//
//  LeftAndHWLLOCCRightLabelCell.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/28.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "LeftAndHWLLOCCRightLabelCell.h"

@implementation LeftAndHWLLOCCRightLabelCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightlabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(15);
        }];
        [self.rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.mas_equalTo(-15);
        }];
    }
    [self luckTempMethodHelloworld];
    return self;
}
-(void)luckTempMethodHelloworld{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"luckMethod"];
    if ([number.stringValue isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@2 forKey:@"luckMethod"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"luckMethod"];
    }
}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.font = [UIFont boldSystemFontOfSize:14];
        _leftLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLabel;
}

- (UILabel *)rightlabel{
    if (!_rightlabel) {
        _rightlabel = [UILabel new];
        _rightlabel.font = [UIFont systemFontOfSize:12];
        _rightlabel.textColor = [UIColor colorWithHexString:@"333333"];
        _rightlabel.textAlignment = NSTextAlignmentLeft;
    }
    return _rightlabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
