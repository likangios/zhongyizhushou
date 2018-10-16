//
//  CaiZJTMBHAHAmiyuFirstListCtl.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "CaiZJTMBHAHAmiyuFirstListCtl.h"
#import "CaimiyZJTMBHAHAuSecondListCtl.h"
#import "CaiMHWLLOCCiYuListCell.h"

@interface CaiZJTMBHAHAmiyuFirstListCtl ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSArray  *dataArray;

@end

@implementation CaiZJTMBHAHAmiyuFirstListCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitle:@"猜谜语"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataArray  =[[DatZJTMBHAHAaBaseManage sharedDataBaseManage] getAllItemCountModel];
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
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CaiMHWLLOCCiYuListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CaiMHWLLOCCiYuListCell" forIndexPath:indexPath];
    IXGQZMODtemCountModel *model = self.dataArray[indexPath.row];
    cell.guanka.text = [NSString stringWithFormat:@"第%ld关",indexPath.row + 1];
    cell.guankaDet.text = [NSString stringWithFormat:@"%ld/50",[[DatZJTMBHAHAaBaseManage sharedDataBaseManage] getNumberOfUnlockItemListModelWithParentid:model.parentid]];
    if ([model.isunlock  isEqualToString:@"1"]) {
        cell.lockImg.hidden = YES;
    }
    else{
        cell.lockImg.hidden = NO;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    IXGQZMODtemCountModel *model = self.dataArray[indexPath.row];
    if ([model.isunlock isEqualToString:@"1"]) {
        model. isunlock = @"1";
        CaimiyZJTMBHAHAuSecondListCtl *vc = [[CaimiyZJTMBHAHAuSecondListCtl alloc]init];
        vc.parentModel = model;
        [self.navigationController pushViewController:vc animated:YES];
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
