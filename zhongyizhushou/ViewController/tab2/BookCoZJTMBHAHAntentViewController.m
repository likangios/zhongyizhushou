//
//  BookCoZJTMBHAHAntentViewController.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "BookCoZJTMBHAHAntentViewController.h"

@interface BookCoZJTMBHAHAntentViewController ()

@property(nonatomic,strong) UILabel *contenLabel;

@property(nonatomic,strong) UITextView *textView;

@property(nonatomic,strong) UIScrollView *scrollViw;

@end

@implementation BookCoZJTMBHAHAntentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDefaultBackItem];
    [self setNavBarTitle:self.title];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.top.equalTo(self.customNavBar.mas_bottom);
    }];
    
    NSMutableAttributedString *muAtt = [[NSMutableAttributedString alloc]initWithString:self.content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [paragraphStyle setParagraphSpacing:8];
        
    [muAtt addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.content length])];
    [muAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, [self.content length])];
    [muAtt addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0, self.content.length)];
    [muAtt addAttribute:NSKernAttributeName value:@(2) range:NSMakeRange(0, [self.content length])];
    self.textView.attributedText = muAtt;
}
- (UIScrollView *)scrollViw{
    if (!_scrollViw) {
        _scrollViw = [[UIScrollView alloc]init];
    }
    return _scrollViw;
}
- (void)setContent:(NSString *)content{
    _content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
}
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.editable = NO;
    }
    return _textView;
}
- (UILabel *)contenLabel{
    if (!_contenLabel) {
        _contenLabel = [UILabel new];
        _contenLabel.font = [UIFont systemFontOfSize:14];
        _contenLabel.numberOfLines = 0;
        _contenLabel.textColor = [UIColor colorWithHexString:@"000000"];
        _contenLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contenLabel;
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
