//
//  ZYTMineCtl.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "ZYTMineCtl.h"
#import "SignInTableViewCell.h"
#import "LeftAndRightLabelCell.h"
#import "HeadTableViewCell.h"
@interface ZYTMineCtl ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;


@end

@implementation ZYTMineCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitle:@"我的"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[AVUser currentUser] refreshInBackgroundWithBlock:^(AVObject * _Nullable object, NSError * _Nullable error) {
        [self.tableView reloadData];
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[HeadTableViewCell class] forCellReuseIdentifier:@"HeadTableViewCell"];
        [_tableView registerClass:[SignInTableViewCell class] forCellReuseIdentifier:@"SignInTableViewCell"];
        [_tableView registerClass:[LeftAndRightLabelCell class] forCellReuseIdentifier:@"LeftAndRightLabelCell"];
        _tableView.tableFooterView = [UIView new];

    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AVUser *currentUser =[AVUser currentUser];
    if (indexPath.row == 0) {
        HeadTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"HeadTableViewCell"];
        cell.nameLabel.text = [NSString stringWithFormat:@"昵称:%@",[currentUser objectForKey:@"nickName"]];
        NSNumber *user_id = [currentUser objectForKey:@"user_id"];
        cell.idLabel.text = [NSString stringWithFormat:@"ID:%ld",user_id.integerValue];
        return cell;

    }
    if (indexPath.row == 1) {
        LeftAndRightLabelCell *cell= [tableView dequeueReusableCellWithIdentifier:@"LeftAndRightLabelCell"];
        cell.leftLabel.text = @"我的金币";
        NSNumber *coin = [currentUser objectForKey:@"coin"];
        cell.rightlabel.text = [NSString stringWithFormat:@"%ld",coin.integerValue];
        return cell;
    }
    if (indexPath.row == 2) {
        SignInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignInTableViewCell"];
        cell.titleLabel.text = @"每日签到";
        NSDate *date = [currentUser objectForKey:@"signIn"];
        if ([AppUntil isToday:date]) {
            cell.signInButton.enabled = NO;
        }
        else{
            cell.signInButton.enabled = YES;
        }
        return cell;
    }
    LeftAndRightLabelCell *cell= [tableView dequeueReusableCellWithIdentifier:@"LeftAndRightLabelCell"];
    cell.leftLabel.text = @"当前版本";
    cell.rightlabel.text = APP_VERSION;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 65.0;
    }
    return 55.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        AVUser *currentUser =[AVUser currentUser];
        NSDate *date = [currentUser objectForKey:@"signIn"];
        if (![AppUntil isToday:date]) {
            NSNumber *coin = [currentUser objectForKey:@"coin"];
            [currentUser setObject:[NSDate date] forKey:@"signIn"];
            [currentUser setObject:[NSNumber numberWithInteger:coin.integerValue + 10] forKey:@"coin"];
            [currentUser save];
            [SVProgressHUD showInfoWithStatus:@"签到成功：金币+10"];
            [self.tableView reloadData];
        }
        else{
            [SVProgressHUD showInfoWithStatus:@"今天已经签到过了，明天再来吧。"];
        }
    }
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
