//
//  XueweitZJTMBHAHAuFirstCtl.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "XueweitZJTMBHAHAuFirstCtl.h"
#import "XuZJTMBHAHAeWeiTuListViewController.h"


@interface XueweitZJTMBHAHAuFirstCtl ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray  *dataArray;

@end

@implementation XueweitZJTMBHAHAuFirstCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitle:@"穴位图"];
    self.dataArray = [[AcupointZJTMBHAHADataManager sharedDataBaseManage] acumainData];
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
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    AcZJTMBHAHAupointListModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AcZJTMBHAHAupointListModel *model = self.dataArray[indexPath.row];
    
    XuZJTMBHAHAeWeiTuListViewController *vc = [[XuZJTMBHAHAeWeiTuListViewController alloc]init];
    vc.dataArray = model.subModel;
    vc.title = model.name;
    [self.navigationController pushViewController:vc animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
