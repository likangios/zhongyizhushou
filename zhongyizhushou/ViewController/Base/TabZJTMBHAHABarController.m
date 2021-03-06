//
//  TabZJTMBHAHABarController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "TabZJTMBHAHABarController.h"
#import "ZYTTestViewController.h"
#import "ZYTUserzhengceViewController.h"
// Controllers
#import "NaviZJTMBHAHAgationController.h"

#import "AppDelegate.h"
// Models

// Views
// Vendors

// Categories

// Others

@interface TabZJTMBHAHABarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSMutableArray *tabBarItems;
//给item加上badge
@property (nonatomic, weak) UITabBarItem *item;

@end

@implementation TabZJTMBHAHABarController

#pragma mark - LazyLoad
- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    
    return _tabBarItems;
}

#pragma mark - LifeCyle

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSString *first =  [[NSUserDefaults standardUserDefaults] valueForKey:@"first"];
    if (![first isEqualToString:@"1"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ZYTUserzhengceViewController *tiaok = [[ZYTUserzhengceViewController alloc]init];
            [self presentViewController:tiaok animated:YES completion:NULL];
        });
    }
}

- (void)pushNotification{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.push && app.url.length) {
        ZYTTestViewController *vc = [[ZYTTestViewController alloc]init];
        vc.loadUrl = app.url;
        if (self.presentedViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                [self presentViewController:vc animated:YES completion:NULL];
            }];
        }
        else{
            [self presentViewController:vc animated:YES completion:NULL];
        }
    }
}

#pragma mark - initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.delegate = self;    
    [self addDcChildViewContorller];
    self.selectedIndex = 0;
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"pushNotification" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self pushNotification];
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


#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"MineZJTMBHAHACtl",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"ico_me_16x16_",
                              MallSelImgKey : @"ico_me_select_16x16_"},
                            
                            @{MallClassKey  : @"ZYTBooksHZJTMBHAHAomePageCtl",
                              MallTitleKey  : @"经典医书",
                              MallImgKey    : @"ico_activity_16x16_",
                              MallSelImgKey : @"ico_activity_select_16x16_"},
                            
                            @{MallClassKey  : @"CaiZJTMBHAHAmiyuFirstListCtl",
                              MallTitleKey  : @"猜中药",
                              MallImgKey    : @"icon_wenda_16x16_",
                              MallSelImgKey : @"icon_wenda_sel_16x16_"},
                            
                            @{MallClassKey  : @"XueweitZJTMBHAHAuFirstCtl",
                              MallTitleKey  : @"穴位图",
                              MallImgKey    : @"icon_xuewei",
                              MallSelImgKey : @"icon_xuewei_sel"},
                            

                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        NaviZJTMBHAHAgationController *nav = [[NaviZJTMBHAHAgationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[MallTitleKey];
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        item.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:DCBGColor} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"7e7e7e"]} forState:UIControlStateNormal];
        [self addChildViewController:nav];
        
        
        // 添加tabBarItem至数组
        [self.tabBarItems addObject:vc.tabBarItem];
    }];
}

#pragma mark - 控制器跳转拦截
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    if ([self.childViewControllers.firstObject isEqual:viewController]) { //根据tabBar的内存地址找到美信发通知jump
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:nil];
    }
    /*
    if(viewController == [tabBarController.viewControllers objectAtIndex:DCTabBarControllerPerson]){
        
        if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
           
        }
        BGLoginViewController *dcLoginVc = [BGLoginViewController new];
        [viewController presentViewController:dcLoginVc animated:YES completion:nil];
    }
    */
    
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];

    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
}


#pragma mark - 更新badgeView
- (void)updateBadgeValue
{
}

#pragma mark - 只要监听的item的属性一有新值，就会调用该方法重新给属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
   
}


#pragma mark - 移除通知
- (void)dealloc {
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

@end
