//
//  XueWeiTZJTMBHAHAuDetailViewController.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "XueWeiTZJTMBHAHAuDetailViewController.h"

@interface XueWeiTZJTMBHAHAuDetailViewController ()

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,strong) UILabel *headLabel;

@property(nonatomic,strong) UILabel *imgLabel;

@property(nonatomic,strong) UIImageView *imgView;

@end

@implementation XueWeiTZJTMBHAHAuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDefaultBackItem];
    [self setNavBarTitle:self.model.name];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.customNavBar.mas_bottom);
    }];
    [self.scrollView addSubview:self.headLabel];
    [self.scrollView addSubview:self.contentLabel];
    [self.scrollView addSubview:self.imgLabel];
    [self.scrollView addSubview:self.imgView];
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.centerX.equalTo(self.scrollView);
        make.height.mas_equalTo(40);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.headLabel.mas_bottom).offset(10);
    }];
    [self.imgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    UIImage *img = [UIImage imageNamed:self.model.image];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.imgLabel.mas_bottom);
        make.height.equalTo(self.imgView.mas_width).multipliedBy(img.size.height/img.size.width);
        make.bottom.mas_lessThanOrEqualTo(-10);
    }];
    self.imgView.image = img;
    
    self.contentLabel.text = self.model.content;
}


- (UIImageView *)imgView{
    if(!_imgView) {
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.backgroundColor = [UIColor randomColor];
    }
    return _imgView;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}
- (UILabel *)imgLabel{
    if (!_imgLabel) {
        _imgLabel = [UILabel new];
        _imgLabel.text = @"  穴位图片";
        _imgLabel.font = [UIFont systemFontOfSize:14];
        _imgLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _imgLabel.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        _imgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _imgLabel;
}
- (UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [UILabel new];
        _headLabel.text = @"  穴位基本信息";
        _headLabel.font = [UIFont systemFontOfSize:14];
        _headLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _headLabel.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        _headLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _headLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
