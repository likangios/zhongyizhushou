//
//  AppDelegate.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "AppDelegate.h"
#import "GDTSplashAd.h"
#import "TabZJTMBHAHABarController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AdSupport/AdSupport.h>
#import "ContXGQZMODrolManager.h"
@interface AppDelegate ()<GDTSplashAdDelegate>
@property(nonatomic,strong) NSDictionary *launchOptions;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self setUpRootVC]; //跟控制器判断
    [self.window makeKeyAndVisible];
    [self setUpFixiOS11]; //适配IOS 11
    self.launchOptions = launchOptions;
    GDTSplashAd *splash = [[GDTSplashAd alloc]initWithAppId:ad_appkey placementId:placementid_open];
    splash.delegate = self;
    splash.fetchDelay = 3;
    [splash loadAdAndShowInWindow:self.window];
    [self initCloud];
    [self luckTempMethodHelloworld];
    return YES;
}
- (void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd{
    NSLog(@"开屏广告展示成功");
}
- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error{
    NSLog(@"开屏广告展示失败：%@",error.description);
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
- (void)initCloud{
    [AVOSCloud setApplicationId:@"d9M5CcW86UbMuJO6BY07W4RU-gzGzoHsz" clientKey:@"GHSBf89FQ6hYVGSBBa4pSxx7"];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    NSString *udid = [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
    [self loginWithName:udid pwd:@"123456"];
}
- (void)loginWithName:(NSString *)name pwd:(NSString *)pwd
{
    NSError *error;
    [AVUser logInWithUsername:name password:pwd error:&error];
    if (error) {
        NSLog(@"========login error is %@",error.description);
        if (error.code == 211) {
            AVUser *user = [[AVUser alloc]init];
            user.username = name;
            user.password = @"123456";
            [user signUp:&error];
            NSLog(@"========signUp error is %@",error.description);
            if (error) {
//                注册失败 稍后再试
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self loginWithName:name pwd:pwd];
                });
            }
            else{
//                注册成功马上登录
                [self loginWithName:name pwd:pwd];
            }
        }
        else{
            //登录失败 稍后再试
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loginWithName:name pwd:pwd];
            });
        }
    }
    else{
//        登录成功
        NSString *nickName = [[UIDevice currentDevice] name];
        [[AVUser currentUser] setObject:nickName forKey:@"nickName"];
        [[AVUser currentUser] save];
        NSLog(@"========登录 成功 ！！！");
    }
}
#pragma mark - 根控制器
- (void)setUpRootVC
{
        self.window.rootViewController = [[TabZJTMBHAHABarController alloc] init];
}

#pragma mark - 适配
- (void)setUpFixiOS11
{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
