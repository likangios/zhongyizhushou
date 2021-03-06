//
//  CaimiyZJTMBHAHAuSecondListCtl.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "CaimiyZJTMBHAHAuSecondListCtl.h"
#import "ZJTMBHAHACaimiyuDetailViewController.h"
#import "CaiMHWLLOCCiYuListCell.h"

@interface CaimiyZJTMBHAHAuSecondListCtl ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSArray  *dataArray;

@end

@implementation CaimiyZJTMBHAHAuSecondListCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDefaultBackItem];
    [self setNavBarTitle:[NSString stringWithFormat:@"第%@关",self.parentModel.parentid]];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    self.dataArray  =[[DatZJTMBHAHAaBaseManage sharedDataBaseManage] getAllItemListModelWithParentid:self.parentModel.parentid];
    [self.collectionView reloadData];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width =  (ScreenW-5)/4.0;
        layout.itemSize = CGSizeMake(width,width) ;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[CaiMHWLLOCCiYuListCell class] forCellWithReuseIdentifier:@"CaiMHWLLOCCiYuListCell"];
        _collectionView.delegate = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CaiMHWLLOCCiYuListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CaiMHWLLOCCiYuListCell" forIndexPath:indexPath];
    ItemXGQZMODListModel *model = self.dataArray[indexPath.row];
    cell.guanka.text = [NSString stringWithFormat:@"第%ld关",indexPath.row + 1];
    if (indexPath.row < self.dataArray.count - 1) {
        ItemXGQZMODListModel *nextModel = self.dataArray[indexPath.row + 1];
        if ([nextModel.isunlock isEqualToString:@"1"]) {
            cell.guankaDet.text = model.answer;
        }
        else{
            cell.guankaDet.text = nil;
        }
    }
    else if(indexPath.row == self.dataArray.count - 1){
        IXGQZMODtemCountModel *nextModel = [[DatZJTMBHAHAaBaseManage sharedDataBaseManage] getItemCountModelWithParentId:[NSString stringWithFormat:@"%ld",model.parentid.integerValue + 1]];
        if ([nextModel.isunlock isEqualToString:@"1"]) {
            cell.guankaDet.text = model.answer;
        }
        else{
            cell.guankaDet.text = nil;
        }
    }
    if ([model.isunlock  isEqualToString:@"1"]) {
        cell.lockImg.hidden = YES;
    }
    else{
        cell.lockImg.hidden = NO;
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemXGQZMODListModel *model = self.dataArray[indexPath.row];
    if ([model.isunlock isEqualToString:@"1"]) {
        if (indexPath.row < self.dataArray.count) {
            ZJTMBHAHACaimiyuDetailViewController *vc =[[ ZJTMBHAHACaimiyuDetailViewController alloc]init];
            vc.dataArray = self.dataArray;
            vc.index = indexPath.row;
            [self.navigationController pushViewController:vc animated:YES];
//            ItemXGQZMODListModel *nextModel = self.dataArray[indexPath.row + 1];
//            nextModel.isunlock = @"1";
//            [[DatZJTMBHAHAaBaseManage sharedDataBaseManage] updateItemList:nextModel];
//            [self.collectionView reloadData];
        }
    }
    else{
        [SVProgressHUD showInfoWithStatus:@"请先完成前面关卡"];
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
