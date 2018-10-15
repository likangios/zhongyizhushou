//
//  ZYTBooksHomePageCtl.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "ZYTBooksHomePageCtl.h"
#import "BookCell.h"
#import "BookListModel.h"
#import "BookListTableViewController.h"
@interface ZYTBooksHomePageCtl ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray  *dataArray;

@end

@implementation ZYTBooksHomePageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setNavBarTitle:@"经典医书"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}
- (void)initData{
    self.dataArray = [NSMutableArray array];
    NSArray *names = @[@"伤寒论",@"难经",@"濒湖脉学",@"医学三字经",@"金匮要略",@"温病条辩",@"千金要方",@"医宗金鉴"];
    NSArray *imgs = @[@"icon_shl_55x55_",@"icon_nj_55x55_",@"icon_bhmx_55x55_",@"icon_yxszj_55x55_",@"icon_jkyl_55x55_",@"icon_wbtb_55x55_",@"icon_qjyf_55x55_",@"icon_yzjj_55x55_"];
    for (int i = 0; i < names.count; i++) {
        BookListModel *model = [[BookListModel alloc]init];
        model.imgName = imgs[i];
        model.bookName = names[i];
        [self.dataArray addObject:model];
    }
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width =  (ScreenW-2)/3.0;
        layout.itemSize = CGSizeMake(width,width) ;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[BookCell class] forCellWithReuseIdentifier:@"BookCell"];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    BookListModel *model = self.dataArray[indexPath.row];
    cell.title.text = model.bookName;
    cell.imgView.image = [UIImage imageNamed:model.imgName];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BookListModel *model = self.dataArray[indexPath.row];
    NSArray *array;
    switch (indexPath.row) {
        case 0:
            array = [[ZYTHardbyBookDataManager sharedDataBaseManage] shanghanlunData];
            break;
        case 1:
            array = [[ZYTHardbyBookDataManager sharedDataBaseManage] hardbyBookData];
            break;
        case 2:
            array = [[ZYTHardbyBookDataManager sharedDataBaseManage] binhumaixueData];
            break;
        case 3:
            array = [[ZYTHardbyBookDataManager sharedDataBaseManage] yixuesanzijingData];
            break;
        case 4:
        case 5:
        case 6:
        case 7:
            array = [[ZYTNewBookDataManager sharedDataBaseManage] newBookDataWithType:indexPath.row-3];
            break;
        default:
            break;
    }
    BookListTableViewController *vc = [[BookListTableViewController alloc]init];
    vc.dataArray = array;
    vc.title = model.bookName;
    [self.navigationController pushViewController:vc animated:YES];
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
