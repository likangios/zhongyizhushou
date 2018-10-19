//
//  MineZJTMBHAHACtl.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "MineZJTMBHAHACtl.h"
#import "SignInTaHWLLOCCbleViewCell.h"
#import "LeftAndHWLLOCCRightLabelCell.h"
#import "HeadTHWLLOCCableViewCell.h"
@interface MineZJTMBHAHACtl ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;


@end

@implementation MineZJTMBHAHACtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitle:@"我的"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self luckTempMethodHelloworld];
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
        [_tableView registerClass:[HeadTHWLLOCCableViewCell class] forCellReuseIdentifier:@"HeadTHWLLOCCableViewCell"];
        [_tableView registerClass:[SignInTaHWLLOCCbleViewCell class] forCellReuseIdentifier:@"SignInTaHWLLOCCbleViewCell"];
        [_tableView registerClass:[LeftAndHWLLOCCRightLabelCell class] forCellReuseIdentifier:@"LeftAndHWLLOCCRightLabelCell"];
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
        HeadTHWLLOCCableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"HeadTHWLLOCCableViewCell"];
        cell.nameLabel.text = [NSString stringWithFormat:@"昵称:%@",[currentUser objectForKey:@"nickName"]];
        NSNumber *user_id = [currentUser objectForKey:@"user_id"];
        cell.idLabel.text = [NSString stringWithFormat:@"ID:%ld",user_id.integerValue];
        return cell;

    }
    if (indexPath.row == 1) {
        LeftAndHWLLOCCRightLabelCell *cell= [tableView dequeueReusableCellWithIdentifier:@"LeftAndHWLLOCCRightLabelCell"];
        cell.leftLabel.text = @"我的积分";
        NSNumber *coin = [currentUser objectForKey:@"coin"];
        cell.rightlabel.text = [NSString stringWithFormat:@"%ld",coin.integerValue];
        return cell;
    }
    if (indexPath.row == 2) {
        SignInTaHWLLOCCbleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignInTaHWLLOCCbleViewCell"];
        cell.titleLabel.text = @"每日签到";
        NSDate *date = [currentUser objectForKey:@"signIn"];
        if ([AppXGQZMODUntil isToday:date]) {
            cell.signInButton.enabled = NO;
        }
        else{
            cell.signInButton.enabled = YES;
        }
        return cell;
    }
    LeftAndHWLLOCCRightLabelCell *cell= [tableView dequeueReusableCellWithIdentifier:@"LeftAndHWLLOCCRightLabelCell"];
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
        if (![AppXGQZMODUntil isToday:date]) {
            NSNumber *coin = [currentUser objectForKey:@"coin"];
            [currentUser setObject:[NSDate date] forKey:@"signIn"];
            [currentUser setObject:[NSNumber numberWithInteger:coin.integerValue + 10] forKey:@"coin"];
            [currentUser save];
            [SVProgressHUD showInfoWithStatus:@"签到成功：积分+10"];
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
