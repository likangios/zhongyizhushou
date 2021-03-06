//
//  AnsHWLLOCCwerCell.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/26.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "AnsHWLLOCCwerCell.h"

@implementation AnsHWLLOCCwerCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor grayColor];
        self.contentView.layer.cornerRadius = 3;
        [self.contentView addSubview:self.tipLabel];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
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
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor colorWithHexString:@"000000"];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipLabel;
}
@end
