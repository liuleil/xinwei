//
//  HomePageViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/22.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "HomePageViewController.h"

#import "TabbarView.h"
#import "TopNewsViewController.h"
#import "OtherNewsViewController.h"
#import "RequestBase+News.h"
#import "NewDetailViewController.h"
#import "CQList.h"
@interface HomePageViewController ()
@property (nonatomic,strong) TabbarView * tabbarView;
@end

@implementation HomePageViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"今日新闻";
 
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
//    DKNightVersionManager *manager = [DKNightVersionManager sharedManager];
//    manager.themeVersion = DKThemeVersionNight;
    [self.view addSubview:self.tabbarView];
    
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(push:) name:@"push" object:nil];

}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//      self.tabBarController.tabBar.hidden = NO;
//
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = yes;
//
//}

-(void)push:(NSNotification *)notification{

   
    NewDetailViewController *newDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewDetailViewController"];
    newDetailViewController.cq_new_list = (CQList *)notification.object;
      self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newDetailViewController animated:YES];
     self.hidesBottomBarWhenPushed=NO;
}
//懒加载
- (TabbarView *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = ({
            
            TabbarView * tabbar = [[TabbarView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
            
            TopNewsViewController * vc0 = [[TopNewsViewController alloc]init];
            vc0.title = @"头条";
            [tabbar addSubItemWithViewController:vc0];
            
          
            
            OtherNewsViewController * vc2 = [[OtherNewsViewController alloc]init];
            vc2.title = @"财经";
            [tabbar addSubItemWithViewController:vc2];
            
            OtherNewsViewController * vc3 = [[OtherNewsViewController alloc]init];
            vc3.title = @"体育";
            [tabbar addSubItemWithViewController:vc3];
            
            OtherNewsViewController * vc4 = [[OtherNewsViewController alloc]init];
            vc4.title = @"娱乐";
            [tabbar addSubItemWithViewController:vc4];
            
            OtherNewsViewController * vc5 = [[OtherNewsViewController alloc]init];
            vc5.title = @"军事";
            [tabbar addSubItemWithViewController:vc5];
            
            OtherNewsViewController * vc6 = [[OtherNewsViewController alloc]init];
            vc6.title = @"教育";
            [tabbar addSubItemWithViewController:vc6];
            
            OtherNewsViewController * vc7 = [[OtherNewsViewController alloc]init];
            vc7.title = @"科技";
            [tabbar addSubItemWithViewController:vc7];
            
            OtherNewsViewController * vc8 = [[OtherNewsViewController alloc]init];
            vc8.title = @"NBA";
            [tabbar addSubItemWithViewController:vc8];
            
            OtherNewsViewController * vc9 = [[OtherNewsViewController alloc]init];
            vc9.title = @"股票";
            [tabbar addSubItemWithViewController:vc9];
            
            tabbar;
        });
    }
    return _tabbarView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
