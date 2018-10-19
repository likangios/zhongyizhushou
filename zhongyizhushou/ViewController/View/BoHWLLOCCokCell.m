//
//  BoHWLLOCCokCell.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/26.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "BoHWLLOCCokCell.h"

@implementation BoHWLLOCCokCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.title];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.mas_equalTo(25);
            make.size.mas_equalTo(55);
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.imgView);
            make.top.equalTo(self.imgView.mas_bottom).offset(10);
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
- (UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor colorWithHexString:@"000000"];
        _title.text = @"123456";
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}
- (UIImageView *)imgView{
    if(!_imgView) {
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}
@end
