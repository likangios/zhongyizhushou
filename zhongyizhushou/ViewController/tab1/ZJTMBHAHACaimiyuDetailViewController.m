//
//  ZJTMBHAHACaimiyuDetailViewController.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/25.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "ZJTMBHAHACaimiyuDetailViewController.h"
#import "AnswHWLLOCCerView.h"
#import "OptHWLLOCCionsAnswer.h"

@interface ZJTMBHAHACaimiyuDetailViewController ()

@property(nonatomic,strong) UILabel *qsTitleLabel;

@property(nonatomic,strong) UILabel *questionLabel;

@property(nonatomic,strong) UILabel *coinLabel;


@property(nonatomic,strong) AnswHWLLOCCerView *answerView;

@property(nonatomic,strong) OptHWLLOCCionsAnswer *optionsAnswer;

@property(nonatomic,strong) ItemXGQZMODListModel *currentModel;

@property(nonatomic,strong) NSMutableString *optionsAnswerString;;

@property(nonatomic,strong) UIButton *tipsButton;

@property(nonatomic,assign) NSInteger coin;


@end

@implementation ZJTMBHAHACaimiyuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AVUser *user = [AVUser currentUser];
    NSNumber *coin = [user objectForKey:@"coin"];
    self.coin = coin.integerValue;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDefaultBackItem];
    [self.view addSubview:self.qsTitleLabel];
    [self.view addSubview:self.coinLabel];
    [self.view addSubview:self.questionLabel];
    [self.view addSubview:self.answerView];
    [self.view addSubview:self.optionsAnswer];
    [self.view addSubview:self.tipsButton];
    [self.qsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.customNavBar.mas_bottom).offset(30);
    }];
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.qsTitleLabel);
        make.right.mas_equalTo(-10);
    }];
    
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.mas_greaterThanOrEqualTo(10);
        make.right.mas_lessThanOrEqualTo(-10);
    }];
    [self.answerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.questionLabel.mas_bottom).offset(150);
    }];
    [self.optionsAnswer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.answerView.mas_bottom).offset(30);
        make.left.right.mas_equalTo(0);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    [self.tipsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(40);
        make.top.equalTo(self.qsTitleLabel.mas_bottom).offset(80);
    }];
    [RACObserve(self, coin) subscribeNext:^(NSNumber *x) {
        AVUser *user = [AVUser currentUser];
        [user setObject:x forKey:@"coin"];
        [user save];
        [user refresh];
        self.coinLabel.text = [NSString stringWithFormat:@"我的积分：%d",x.integerValue];
    }];
    
    self.optionsAnswerString = [[NSMutableString alloc]init];
    @weakify(self);
    [RACObserve(self, index) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self setNavBarTitle:[NSString stringWithFormat:@"关卡（%ld/%lu）",(long)self.index+1,(unsigned long)self.dataArray.count]];
        self.qsTitleLabel.text = self.currentModel.tips;
        self.questionLabel.text = self.currentModel.title;
        NSInteger count = self.index;
        while (self.optionsAnswerString.length < 20 && count < self.dataArray.count) {
            ItemXGQZMODListModel *model = self.dataArray[count];
            [self.optionsAnswerString appendFormat:@"%@", [model.answer stringByReplacingOccurrencesOfString:@" " withString:@""]];
            count++;
            if (count == self.dataArray.count && self.optionsAnswerString.length < 20) {
                count = 0;
            }
        }
        self.optionsAnswer.optionAnswer = [self.optionsAnswerString substringWithRange:NSMakeRange(0, 20)];
        self.answerView.rightAnswer = self.currentModel.answer;
        
        if ([self.currentModel.isunlock isEqualToString:@"0"]) {
            self.currentModel.isunlock = @"1";
            [[DatZJTMBHAHAaBaseManage sharedDataBaseManage] updateItemList:self.currentModel];
        }

    }];
    [self.optionsAnswer.optionAnswerSignal subscribeNext:^(AnsHWLLOCCwerModel *x) {
        @strongify(self);
        for (int i = 0; i<self.answerView.Answer.count; i++) {
            id obj = self.answerView.Answer[i];
            if ([obj isKindOfClass:[NSNumber class]]) {
                x.selected = YES;
                [self.answerView.Answer replaceObjectAtIndex:i withObject:x];
                [self.answerView updateSubViews];
                [self.optionsAnswer updateCollectionView];
                break;
            }
        }
    }];
    [self.answerView.answerClickSignal subscribeNext:^(AnsHWLLOCCwerModel * x) {
        @strongify(self);
        NSInteger index = [self.answerView.Answer indexOfObject:x];
        [self.answerView.Answer replaceObjectAtIndex:index withObject:@(1)];
        [self.answerView updateSubViews];
        x.selected = NO;
        [self.optionsAnswer updateCollectionView];
    }];
    [self.answerView.answerRightSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.index < self.dataArray.count - 1) {
            self.coin ++;
            NSString *message = self.currentModel.answertips;
            [UIAlertView bk_showAlertViewWithTitle:@"答对了！" message:message cancelButtonTitle:nil otherButtonTitles:@[@"下一关"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                self.index++;
            }];
        }
        else{
            [UIAlertView bk_showAlertViewWithTitle:@"恭喜" message:@"本关所有题目已经答完。" cancelButtonTitle:nil otherButtonTitles:@[@"返回，进入下一关"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                //更新大关卡
                IXGQZMODtemCountModel *model = [[DatZJTMBHAHAaBaseManage sharedDataBaseManage] getItemCountModelWithParentId:[NSString stringWithFormat:@"%ld",self.currentModel.parentid.integerValue + 1]];
                if (model && [model.isunlock isEqualToString:@"0"]) {
                    model.isunlock = @"1";
                    [[DatZJTMBHAHAaBaseManage sharedDataBaseManage] updateItemCount:model];
                }
                //更新小关卡
                NSString *nextTitleId = [NSString stringWithFormat:@"%ld",self.currentModel.titleid.integerValue + 1];
                ItemXGQZMODListModel *listModel = [[DatZJTMBHAHAaBaseManage sharedDataBaseManage] getItemListModelWithTitleId:nextTitleId];
                if (listModel && [listModel.isunlock isEqualToString:@"0"]) {
                    listModel.isunlock = @"1";
                    [[DatZJTMBHAHAaBaseManage sharedDataBaseManage] updateItemList:listModel];
                }
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }

    }];
    [[self.tipsButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        AVUser *user = [AVUser currentUser];
        NSNumber *coin = [user objectForKey:@"coin"];
        if (coin.integerValue < 5) {
            [SVProgressHUD showInfoWithStatus:@"积分不够了"];
            return ;
        }
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"使用5个积分查看提示？" cancelButtonTitle:@"不看了" otherButtonTitles:@[@"看"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                self.coin -= 5;
            NSString *tips = self.currentModel.answertips.length?self.currentModel.answertips:self.currentModel.answer;
            [UIAlertView bk_showAlertViewWithTitle:@"提示" message:tips cancelButtonTitle:nil otherButtonTitles:@[@"OK"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            }];
            }
        }];
        

    }];
}

- (AnsHWLLOCCwerModel *)currentModel{
    if (self.index < self.dataArray.count) {
        return self.dataArray[self.index];
    }
    return nil;
}
- (UILabel *)qsTitleLabel{
    if (!_qsTitleLabel) {
        _qsTitleLabel = [UILabel new];
        _qsTitleLabel.font = [UIFont boldSystemFontOfSize:16];
        _qsTitleLabel.textColor = [UIColor blackColor];
        _qsTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _qsTitleLabel;
}
- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [UILabel new];
        _coinLabel.font = [UIFont systemFontOfSize:14];
        _coinLabel.textColor = DCBGColor;
        _coinLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _coinLabel;
}
- (UILabel *)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [UILabel new];
        _questionLabel.textColor = [UIColor blackColor];
        _questionLabel.numberOfLines = 0;
        _questionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _questionLabel;
}
- (UIButton *)tipsButton{
    if (!_tipsButton) {
        _tipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tipsButton setImage:[UIImage imageNamed:@"tips"] forState:UIControlStateNormal];
        [_tipsButton setTitle:@"" forState:UIControlStateNormal];
    }
    return _tipsButton;
}

- (AnswHWLLOCCerView *)answerView{
    if (!_answerView) {
        _answerView = [[AnswHWLLOCCerView alloc]init];
    }
    return _answerView;
}
- (OptHWLLOCCionsAnswer *)optionsAnswer{
    if (!_optionsAnswer) {
        _optionsAnswer = [[OptHWLLOCCionsAnswer alloc]init];
    }
    return _optionsAnswer;
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
