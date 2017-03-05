//
//  AppDelegate.m
//  xinwei
//
//  Created by leileigege on 2017/2/22.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import "DataBase.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [DataBase createTable];
    [self UMSharSina];
    
    return YES;
}

#pragma mark - 分享到新浪微博
-(void)UMSharSina{
    

    [[UMSocialManager defaultManager] openLog:YES];
  
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58b44dcce88bad488a001ac8"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
//    设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx6fa2f3ca3570686e" appSecret:@"6abcc8635eb33ee9b9c3fd00249a46e3" redirectURL:@"www.null.com"];

    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"4002484805"  appSecret:@"9e593ff79e7ba9c593b2e4cedb537d84" redirectURL:@"https://itunes.apple.com/cn/genre/音乐/id34"];






}
#pragma mark - 初始化TabBarController
-(void)initializeTheTabBar{
    UITabBarController *tabCtr = [[UITabBarController alloc]init];
    self.window.rootViewController = tabCtr;
    





}
- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
 
}


@end
