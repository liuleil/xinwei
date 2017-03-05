//
//  OtherNewsViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/23.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "OtherNewsViewController.h"
#import "NewsTableViewCell.h"
#import "RequestBase+News.h"
#import "CQRootClass.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "NewDetailViewController.h"
@interface OtherNewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) CQRootClass *newsModel;
@end

@implementation OtherNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.8];
  
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestNews];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
#pragma mark - 网络请求
-(void)requestNews{
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
    
    [RequestBase sendRequstWithChannel:self.title num:@10 start:@0 completionHandler:^(id responseObj, NSError *error) {
        if (!error) {
            self.newsModel =(CQRootClass *) responseObj;
            NSLog(@"%@",[self.newsModel.result.list[1] title]);
            [self.view addSubview:self.tableView];
            [SVProgressHUD dismiss];
        }
        else{
            [SVProgressHUD dismiss];
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络错误" preferredStyle:1];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertCon addAction:cancelAction];
            [self presentViewController:alertCon animated:YES completion:nil];
            
            
            
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


   return [self.newsModel.result.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    cell.title.text = [self.newsModel.result.list[indexPath.row] title];
    cell.from.text = [self.newsModel.result.list[indexPath.row] src];
    cell.time.text = (NSString *)[self.newsModel.result.list[indexPath.row] time];
    [cell.newsImage sd_setImageWithURL:[NSURL URLWithString:[self.newsModel.result.list[indexPath.row] pic]] placeholderImage:[UIImage imageNamed:@"placeHold"]];
      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        [[NSNotificationCenter defaultCenter] postNotificationName:@"push" object:self.newsModel.result.list[indexPath.row] userInfo:nil];

}



-(UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil]  forCellReuseIdentifier:@"newsCell"];
        
    }

    return _tableView;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
