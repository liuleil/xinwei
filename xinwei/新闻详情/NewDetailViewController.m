//
//  NewDetailViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/27.
//  Copyright © 2017年 liulei. All rights reserved.
//
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
#import "NewDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "SourceViewController.h"
#import "DataBase.h"
@interface NewDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation NewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
    self.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.newsTitle.text = self.cq_new_list.title;
    self.from.text = self.cq_new_list.src;
    self.time.text = self.cq_new_list.time;

    self.webView.scrollView.contentInset =UIEdgeInsetsMake(SCREEN_WIDTH/2.0, 0, 0, 0);
    UIImageView *imgview = [[UIImageView alloc] init];
    [imgview sd_setImageWithURL:[NSURL URLWithString:self.cq_new_list.pic] placeholderImage:[UIImage imageNamed:@"placeHold"]];
    imgview.frame = CGRectMake(0, -SCREEN_WIDTH/2.0,SCREEN_WIDTH, SCREEN_WIDTH/2.0);
    [_webView.scrollView addSubview:imgview];
//       NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.cq_new_list.url]];
//    [self.webView loadRequest:request];
    [self.webView loadHTMLString:self.cq_new_list.content baseURL:nil];
    
    
    UILabel *midLab = [UILabel new];
    midLab.text = @"若信息不全请单击'源网站'";
    midLab.textColor = [UIColor redColor];
    midLab.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 21);
    midLab.center = CGPointMake(SCREEN_WIDTH*1.5,100);
    [self.view addSubview:midLab];
    
    [UIView animateWithDuration:10 animations:^{
         midLab.center = CGPointMake(-SCREEN_WIDTH*1.5, 100);
    } completion:^(BOOL finished) {
        [midLab removeFromSuperview];
    }];
 
    
}
- (IBAction)collection:(UIButton *)sender {
    [DataBase insertNews:self.cq_new_list];
    NSString *path = NSHomeDirectory();//主目录
    NSLog(@"NSHomeDirectory:%@",path);
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:1];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertCon addAction:cancelAction];
    [self presentViewController:alertCon animated:YES completion:nil];
    

//    [DataBase insertData];
    
    
}

- (IBAction)goToUrl:(UIButton *)sender {
    SourceViewController *sourceViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SourceViewController"];
    sourceViewController.urlStr = self.cq_new_list.url;
      self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sourceViewController animated:YES];
    
    
}
- (IBAction)share:(UIButton *)sender {
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
      
            [self shareWebPageToPlatformType:platformType];
//            [self shareTextToPlatformType:platformType];
        
               }];
}
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.cq_new_list.title descr:self.cq_new_list.time thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =self.cq_new_list.url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - 隐藏tabBar

//-(void)viewDidAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
//
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    
// self.hidesBottomBarWhenPushed = NO;
//}
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
