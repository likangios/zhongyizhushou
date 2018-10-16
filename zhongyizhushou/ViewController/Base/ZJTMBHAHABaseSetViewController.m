
//
//  ZJTMBHAHABaseSetViewController.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/1.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "ZJTMBHAHABaseSetViewController.h"

// Controllers
#import "TabZJTMBHAHABarController.h"
// Models

// Views

// Vendors

// Categories

// Others
#define navBarTitleFont 18
#define navBarItemFont 15


@interface ZJTMBHAHABaseSetViewController ()

@property (nonatomic,strong) UIView     *bottomLine;

@property (nonatomic,assign) NSUInteger viewDisplayCount;

@end

@implementation ZJTMBHAHABaseSetViewController

#pragma mark - LazyLoad

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self.view bringSubviewToFront:self.customNavBar];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.viewDisplayCount += 1;
   
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    [self creatCustomNavBar];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self bottomLine];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar) name:@"UIApplicationDidChangeStatusBarFrameNotification" object:nil];
    self.statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(BOOL) IsFirstTimeDisplay
{
    if( self.viewDisplayCount == 1 )
        return YES;
    return NO;
}
- (void)hidenNavBar{
    self.customNavBar.hidden = YES;
}

// 热点被接入，子类重写
- (void)adjustStatusBar{
    CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    if (self.statusBarHeight != height) {
        self.statusBarHeight = height;
    }
    
}

- (UILabel *)backTipLabel{
    
    if (!_backTipLabel) {
        _backTipLabel = [UILabel new];
        _backTipLabel.text = @"";
        _backTipLabel.hidden = YES;
        _backTipLabel.textColor = [UIColor whiteColor];
        _backTipLabel.font = [UIFont systemFontOfSize:12];
        _backTipLabel.backgroundColor = [UIColor blackColor];
        _backTipLabel.layer.cornerRadius = 9;
        _backTipLabel.textAlignment = NSTextAlignmentCenter;
        _backTipLabel.layer.masksToBounds = YES;
        [self.customNavBar addSubview:_backTipLabel];
        [_backTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(44);
            make.centerY.equalTo(self.customNavBar).offset(10);
            make.width.mas_greaterThanOrEqualTo(18);
            make.height.mas_equalTo(18);
            
        }];
        
    }
    return _backTipLabel;
}
- (UIButton *)leftItemBtn{
    if (!_leftItemBtn) {
        _leftItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftItemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftItemBtn.titleLabel.font = [UIFont systemFontOfSize:navBarItemFont];
        _leftItemBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftItemBtn addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.customNavBar addSubview:_leftItemBtn];
        
        [_leftItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(16);
            make.width.mas_greaterThanOrEqualTo(44);
            
        }];
    }
    return _leftItemBtn;
}
- (UIButton *)rightItemBtn{
    if (!_rightItemBtn) {
        _rightItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightItemBtn.titleLabel.font = [UIFont systemFontOfSize:navBarItemFont];
        [_rightItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_rightItemBtn addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.customNavBar addSubview:_rightItemBtn];
        [_rightItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.width.mas_greaterThanOrEqualTo(44);
            
        }];
    }
    return _rightItemBtn;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:navBarTitleFont];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.customNavBar addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.customNavBar).offset(10);
            make.centerX.equalTo(self.customNavBar);
            make.left.greaterThanOrEqualTo(self.customNavBar).offset(60);
            make.right.lessThanOrEqualTo(self.customNavBar).offset(-60);
            
        }];
    }
    return  _titleLabel;
}
- (void)creatCustomNavBar{
    _customNavBar = [[UIView alloc]init];
    _customNavBar.backgroundColor = DCBGColor;
    [self.view addSubview:_customNavBar];
    [_customNavBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(navBarH);
    }];
    
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        //_bottomLine.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
        [self.customNavBar addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.equalTo(self.customNavBar);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return _bottomLine;
}

- (void)hidenBottomLine
{
    self.bottomLine.hidden = YES;
}

- (void)addDefaultBackItem{
    
    [self setLeftItemImage:@"icon_back_white_18x18_"];
    
}
- (void)setNavBarTitle:(NSString *)title{
    
    self.titleLabel.text = title;
}

- (void)setLeftItemTitle:(NSString *)title{
    [self.leftItemBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setLeftItemImage:(NSString *)imageName{
    [self.leftItemBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setRightItemTitle:(NSString *)title{
    [self.rightItemBtn setTitle:title forState:UIControlStateNormal];
    
}

- (void)setRightItemImage:(NSString *)imageName{
    [self.rightItemBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}

- (void)leftItemAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightItemAction:(id)sender{
    
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





