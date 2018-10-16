//
//  AnswHWLLOCCerView.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/25.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswHWLLOCCerView : UIView

@property(nonatomic,strong) NSString *rightAnswer;

@property(nonatomic,strong) NSMutableArray *Answer;

@property(nonatomic,strong) RACSubject *answerClickSignal;

@property(nonatomic,strong) RACSubject *answerRightSignal;

- (void)updateSubViews;
@end
