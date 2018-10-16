//
//  OptHWLLOCCionsAnswer.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/25.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptHWLLOCCionsAnswer : UIView

@property(nonatomic,strong) RACSubject *optionAnswerSignal;

@property(nonatomic,strong) NSString *optionAnswer;

@property(nonatomic,strong) NSMutableArray *dataArray;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)updateCollectionView;
@end
