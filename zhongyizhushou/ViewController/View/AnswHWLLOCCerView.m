//
//  AnswHWLLOCCerView.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/25.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "AnswHWLLOCCerView.h"
@interface AnswHWLLOCCerView()

@property(nonatomic,strong) UIView *bgView;

@end

@implementation AnswHWLLOCCerView
- (RACSubject *)answerClickSignal{
    if (!_answerClickSignal) {
        _answerClickSignal = [RACSubject subject];
    }
    return _answerClickSignal;
}
- (RACSubject *)answerRightSignal{
    if (!_answerRightSignal) {
        _answerRightSignal = [RACSubject subject];
    }
    return _answerRightSignal;
}
- (void)setRightAnswer:(NSString *)rightAnswer{
    _rightAnswer = [rightAnswer stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self creatAnswerButton];
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
- (void)creatAnswerButton{
    for (UIButton *btn in self.bgView.subviews) {
        [btn removeFromSuperview];
    }
    self.Answer = [NSMutableArray array];
    UIButton *lastBtn;
    for (int i = 0; i<self.rightAnswer.length;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1;
        [self.bgView addSubview:button];
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.backgroundColor = [UIColor blackColor];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(35, 35));
            make.centerY.equalTo(self.bgView);
            make.top.bottom.mas_equalTo(0);
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(4);
            }
            else{
                make.left.mas_equalTo(0);
            }
        }];
        lastBtn = button;
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * x) {
            id obj  = self.Answer[x.tag - 1];
            if ([obj isKindOfClass:[AnsHWLLOCCwerModel class]]) {
                [self.answerClickSignal sendNext:obj];
            }
        }];
        [self.Answer addObject:@(i+1)];
    }
    [lastBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
    }];
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView =[UIView new];
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}
- (void)updateSubViews{
    
    for (int i=  0; i<self.Answer.count; i++) {
        UIButton *button = [self.bgView viewWithTag:i+1];
        id obj = self.Answer[i];
        if ([obj isKindOfClass:[NSNumber class]]) {
            [button setTitle:@"" forState:UIControlStateNormal];
        }
        else if ([obj isKindOfClass:[AnsHWLLOCCwerModel class]]){
            AnsHWLLOCCwerModel *model = (AnsHWLLOCCwerModel *)obj;
            [button setTitle:model.answer forState:UIControlStateNormal];
        }
    }
    BOOL selectAll =  [self.Answer bk_all:^BOOL(id obj) {
        return [obj isKindOfClass:[AnsHWLLOCCwerModel class]];
    }];
    if (selectAll) {
        NSArray *selectedAnswer = [self.Answer bk_map:^id(AnsHWLLOCCwerModel *obj) {
            return obj.answer;
        }];
        if ([[selectedAnswer componentsJoinedByString:@""] isEqualToString:self.rightAnswer]) {
            [self updateButtonTextColor:[UIColor greenColor]];
            [self.answerRightSignal sendNext:@(1)];
        }
        else{
            [self updateButtonTextColor:[UIColor redColor]];
        }
    }
    else{
        [self updateButtonTextColor:[UIColor whiteColor]];
    }
}
- (void)updateButtonTextColor:(UIColor *)color{
    for (int i=  0; i<self.Answer.count; i++) {
        UIButton *button = [self.bgView viewWithTag:i+1];
        [button setTitleColor:color forState:UIControlStateNormal];
    }
}
@end
