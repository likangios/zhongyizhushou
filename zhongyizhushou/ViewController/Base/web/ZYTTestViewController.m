//
//  ZYTTestViewController.m
//  yezjk
//
//  Created by perfay on 2018/10/11.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "ZYTTestViewController.h"
#import <WebKit/WebKit.h>
#import "LUCKBottomView.h"
@interface ZYTTestViewController ()<WKNavigationDelegate>

@property(nonatomic,strong) WKWebView *webView;

@property(nonatomic,strong) LUCKBottomView *bottomView;

@property(nonatomic,strong) UIProgressView *progressView;

@end

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation ZYTTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.progressView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        if(KIsiPhoneX) {
            make.top.mas_equalTo(45);
        }
        else{
            make.top.mas_equalTo(0);
        }
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        if(KIsiPhoneX) {
            make.bottom.mas_equalTo(-35);
        }
        else{
            make.bottom.mas_equalTo(0);
        }
        make.height.mas_equalTo(45);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
    
    if (self.loadUrl.length) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
    }
    @weakify(self);
    [[self.webView rac_valuesForKeyPath:@"estimatedProgress" observer:self] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.progressView.progress = x.floatValue;
        if (self.progressView.progress == 1) {
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.2f);
            } completion:^(BOOL finished) {
                self.progressView.hidden = YES;
                self.progressView.progress = 0;
                
            }];
        }
    }];
}
#pragma mark - WKdelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progressView.hidden = NO;
    [self.view bringSubviewToFront:self.progressView];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    self.progressView.hidden = YES;
}
- (WKWebView *)webView{
    if (!_webView) {
        NSMutableString *javascritp = [[NSMutableString alloc]init];
        [javascritp appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
        [javascritp appendString:@"document.documentElement.style.webkitUserSelect='none';"];
        WKUserScript *script = [[WKUserScript alloc]initWithSource:javascritp injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        
        WKUserContentController *usercontroller = [[WKUserContentController alloc]init];
        [usercontroller addUserScript:script];
        WKWebViewConfiguration *webviewConfig = [[WKWebViewConfiguration alloc]init];
        webviewConfig.processPool = [[WKProcessPool alloc]init];
        webviewConfig.allowsInlineMediaPlayback = YES;
        webviewConfig.userContentController = usercontroller;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webviewConfig];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.allowsLinkPreview = false;
    }
    return _webView;
}
- (LUCKBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[LUCKBottomView alloc]init];
        [_bottomView setButtonClick:^(NSInteger index) {
            switch (index) {
                case 1:
                    [self goHome];
                    break;
                case 2:
                    [self goBack];
                    break;
                case 3:
                    [self goForward];
                    break;
                case 4:
                    [self goReload];
                    break;
                case 5:
                    [self goSafari];
                    break;
                default:
                    break;
            }
        }];
    }
    return _bottomView;
}
- (BOOL)currentUrlIsNIll {
    if (self.webView.URL.absoluteString == nil) {
        return  YES;
    }
    return NO;
}
- (void)goHome{
    if (self.webView.backForwardList.backList.count) {
        [self.webView goToBackForwardListItem:self.webView.backForwardList.backList.firstObject];
    }else{
        [self loadMainUrl];
    }
}
- (void)goBack{
    if ([self currentUrlIsNIll]) {
        [self loadMainUrl];
    }
    else{
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }
    }
}
- (void)goForward{
    if ([self currentUrlIsNIll]) {
        [self loadMainUrl];
    }
    else{
        if ([self.webView canGoForward]) {
            [self.webView goForward];
        }
    }
}
- (void)goReload{
    if ([self currentUrlIsNIll]) {
        [self loadMainUrl];
    }
    else{
        [self.webView reload];
    }
}
- (void)goSafari{
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"是否使用浏览器打开" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self openSafari];
        }
    }];
}
- (void)openSafari{
    if ([[UIApplication sharedApplication] canOpenURL:self.webView.URL]) {
        [[UIApplication sharedApplication] openURL:self.webView.URL];
    }
}
- (void)loadMainUrl{
    if (!self.loadUrl.length) {
        exit(0);
        return;
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]init];
        _progressView.progressTintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.hidden = YES;
    }
    return _progressView;
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
