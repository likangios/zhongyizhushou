//
//  CaiMHWLLOCCiYuListCell.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "CaiMHWLLOCCiYuListCell.h"

@interface CaiMHWLLOCCiYuListCell ()

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UIImageView *bgImageView;


@end

@implementation CaiMHWLLOCCiYuListCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgImageView];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.lockImg];
        [self.bgView addSubview:self.guanka];
        [self.bgView addSubview:self.guankaDet];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
        [self.guanka mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.bottom.equalTo(self.bgView.mas_centerY).offset(-5);
        }];
        [self.guankaDet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.bgView.mas_centerY).offset(5);
        }];
        
        [self.lockImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.bgView);
        }];
        
    }
    [self luckTempMethodHelloworld];
    return self;
}

- (UIImageView *)bgImageView{
    if(!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.contentMode = UIViewContentModeCenter;
        _bgImageView.image = [UIImage imageNamed:@"caimiyu"];
    }
    return _bgImageView;
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
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor clearColor];
//        _bgView.layer.borderColor = DCBGColor.CGColor;
//        _bgView.layer.borderWidth = 1;
    }
    return _bgView;
}
- (UIImageView *)lockImg{
    if(!_lockImg) {
        _lockImg = [UIImageView new];
        _lockImg.image = [UIImage imageNamed:@"lock"];
        _lockImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _lockImg;
}
- (UILabel *)guanka{
    if (!_guanka) {
        _guanka = [UILabel new];
        _guanka.font = [UIFont boldSystemFontOfSize:14];
//        _guanka.textColor = [UIColor colorWithHexString:@"333333"];
        _guanka.textColor = [UIColor blueColor];
        _guanka.textAlignment = NSTextAlignmentCenter;
    }
    return _guanka;
}
- (UILabel *)guankaDet{
    if (!_guankaDet) {
        _guankaDet = [UILabel new];
        _guankaDet.font = [UIFont boldSystemFontOfSize:14];
        _guankaDet.textColor = [UIColor blueColor];
//        _guankaDet.textColor = [UIColor colorWithHexString:@"333333"];
        _guankaDet.textAlignment = NSTextAlignmentCenter;
    }
    return _guankaDet;
}
@end
