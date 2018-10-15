//
//  ZYTOptionsAnswer.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/25.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "ZYTOptionsAnswer.h"
#import "AnswerCell.h"

@interface ZYTOptionsAnswer ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ZYTOptionsAnswer

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray array];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [RACObserve(self, optionAnswer) subscribeNext:^(NSString * x) {
            if (!x.length) {
                return ;
            }
            [self.dataArray removeAllObjects];
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i<x.length; i++) {
                ZYTAnswerModel *model = [[ZYTAnswerModel alloc]init];
                model.answer = [x substringWithRange:NSMakeRange(i, 1)];
                model.selected = NO;
                [array addObject:model];
            }
            [self.dataArray addObjectsFromArray:[self getRandomObjFromArray:20 FromArray:array]];
            [self.collectionView  reloadData];
        }];
    }
    return self;
}
- (void)updateCollectionView{
    [self.collectionView  reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return MIN(20, self.dataArray.count);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AnswerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnswerCell" forIndexPath:indexPath];
    ZYTAnswerModel *model = self.dataArray[indexPath.row];
    cell.tipLabel.text = model.answer;
    if (model.selected) {
        cell.contentView.hidden = YES;
    }
    else{
        cell.contentView.hidden = NO;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZYTAnswerModel *model = self.dataArray[indexPath.row];
    if (!model.selected) {
        [self.optionAnswerSignal sendNext:model];
    }
}
- (NSArray *)getRandomObjFromArray:(NSInteger)count FromArray:(NSArray *)dataArray{
    
    dataArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(ZYTAnswerModel * obj1, ZYTAnswerModel * obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [obj1.answer compare:obj2.answer];
        }
        else{
            return [obj2.answer compare:obj1.answer];
        }
    }];
    NSMutableArray *newData = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        [newData addObject:dataArray[i%dataArray.count]];
    }
    return newData;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = (ScreenW - 20)/10.0;
        layout.itemSize = CGSizeMake(width, width);
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[AnswerCell class] forCellWithReuseIdentifier:@"AnswerCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled =NO;
    }
    return _collectionView;
}
- (RACSubject *)optionAnswerSignal{
    if (!_optionAnswerSignal) {
        _optionAnswerSignal = [RACSubject subject];
    }
    return _optionAnswerSignal;
}
@end
