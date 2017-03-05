//
//  CJTabBarController.m
//  xinwei
//
//  Created by leileigege on 2017/2/22.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "CJTabBarController.h"
#import "HomePageViewController.h"
#import "CollectViewController.h"
#import "SetViewController.h"
#import "SearchViewController.h"
#import <DKNightVersion/DKNightVersion.h>

@interface CJTabBarController ()

@end

@implementation CJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
    self.tabBar.translucent = NO;
    UITabBarItem *tabbbarItem = [UITabBarItem appearance];
    [tabbbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:116/255.0 green:116/255.0 blue:116/255.0 alpha:1.0]} forState:UIControlStateNormal];
    [tabbbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:252/255.0 green:109/255.0 blue:7/255.0 alpha:1.0]} forState:UIControlStateSelected];
    [self setViewControllers];
}


-(void)setViewControllers{
    HomePageViewController *homePageViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageViewController"];
    UINavigationController *homePageNav= [[UINavigationController alloc] initWithRootViewController:homePageViewController];
    
    
    UIImage *homePageImage = [[UIImage imageNamed:@"homepagenomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homePageImageSelectedImage = [[UIImage imageNamed:@"homepageselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homePageNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:homePageImage selectedImage:homePageImageSelectedImage];
    
    
    CollectViewController *collectViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"CollectViewController"];
    
    UINavigationController *CollectNav= [[UINavigationController alloc] initWithRootViewController:collectViewController];
    
    
    UIImage *CollectImage = [[UIImage imageNamed:@"collectnomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *CollectSelectedImage = [[UIImage imageNamed:@"collectnomalselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CollectNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"收藏" image:CollectImage selectedImage:CollectSelectedImage];
    
    
    
    
    SetViewController *setViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"SetViewController"];
    UINavigationController *setNav= [[UINavigationController alloc] initWithRootViewController:setViewController];
    
    
    UIImage *setImage = [[UIImage imageNamed:@"setnomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *setSelectedImage = [[UIImage imageNamed:@"setnomalselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    setNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:setImage selectedImage:setSelectedImage];
    
    
    
    
    SearchViewController *searchViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    UINavigationController *searchNav= [[UINavigationController alloc] initWithRootViewController:searchViewController];
    
    
    UIImage *searchImage = [[UIImage imageNamed:@"searchBar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *searchSelectedImage = [[UIImage imageNamed:@"searchBar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:searchImage selectedImage:searchSelectedImage];
    
    
    
    
    [self setViewControllers:@[homePageNav,searchNav,CollectNav,setNav]];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}



@end
