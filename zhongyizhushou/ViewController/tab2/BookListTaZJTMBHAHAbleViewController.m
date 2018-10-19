//
//  BookListTaZJTMBHAHAbleViewController.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "BookListTaZJTMBHAHAbleViewController.h"
#import "BookCoZJTMBHAHAntentViewController.h"
@interface BookListTaZJTMBHAHAbleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;


@end

@implementation BookListTaZJTMBHAHAbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDefaultBackItem];
    [self setNavBarTitle:self.title];
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
    BookXGQZMODBaseModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookXGQZMODBaseModel *model = self.dataArray[indexPath.row];
    if ([model isKindOfClass:[BookXGQZMODMuLuModel class]]) {
        BookXGQZMODMuLuModel *mlmodel = (BookXGQZMODMuLuModel *)model;
        if (mlmodel.subModel.count) {
            BookListTaZJTMBHAHAbleViewController *vc = [[BookListTaZJTMBHAHAbleViewController alloc]init];
            vc.dataArray = mlmodel.subModel;
            vc.title = model.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            BookCoZJTMBHAHAntentViewController *vc = [[BookCoZJTMBHAHAntentViewController alloc]init];
            vc.content = mlmodel.content;
            vc.title = mlmodel.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else{
        BookCoZJTMBHAHAntentViewController *vc = [[BookCoZJTMBHAHAntentViewController alloc]init];
        BookConteXGQZMODntModel *contentModel = (BookConteXGQZMODntModel *)model;
        vc.content = contentModel.content;
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
