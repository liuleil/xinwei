//
//  TopNewsViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/23.
//  Copyright © 2017年 liulei. All rights reserved.
//
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#import "Masonry.h"
#import "TopNewsViewController.h"
#import "RequestBase+News.h"
#import <SFFocusViewLayout.h>
#import "TopViewCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "CQRootClass.h"
#import <SVProgressHUD.h>
#import <DKNightVersion/DKNightVersion.h>
#import "NewDetailViewController.h"
@interface TopNewsViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) CQRootClass *newsModel;
@property(nonatomic,strong) UIButton *goTopBtn;
@end

@implementation TopNewsViewController
#pragma mark - 视图控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
   
    [self requestNews];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 网络请求
-(void)requestNews{
//    提示框显示
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
//    请求
    
    [RequestBase sendRequstWithChannel:@"头条" num:@10 start:@0 completionHandler:^(id responseObj, NSError *error) {
    
        if (!error) {
            self.newsModel =(CQRootClass *) responseObj;
            NSLog(@"%@",[self.newsModel.result.list[1] title]);
           [self.view addSubview:self.collectionView];
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
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [self.newsModel.result.list count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TopViewCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"topNews" forIndexPath:indexPath];
    cell.title.text = [self.newsModel.result.list[indexPath.row] title];
    cell.from.text = [self.newsModel.result.list[indexPath.row] src];
    cell.time.text = (NSString *)[self.newsModel.result.list[indexPath.row] time];
    [cell.backGroundImage sd_setImageWithURL:[NSURL URLWithString:[self.newsModel.result.list[indexPath.row] pic]] placeholderImage:[UIImage imageNamed:@"beijing.jpg"]];
    return cell;

}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"push" object:self.newsModel.result.list[indexPath.row] userInfo:nil];

}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 200) {
        if (_goTopBtn) {
            [self.goTopBtn removeFromSuperview];
            self.goTopBtn = nil;
        }
        
    }
    if (scrollView.contentOffset.y >=  200) {
        if (!_goTopBtn) {
            NSLog(@"添加添加添加");
            [self addGoTopButton];
        }
    }






}
#pragma mark - 按钮响应事件
-(void)goToTop{

    CGPoint point = CGPointZero;
//    [self.collectionView ]
//   [self.collectionView setContentOffset:(CGPoint)contentOffset animated:(BOOL)animate;
    [self.collectionView setContentOffset:point animated:YES];




}
#pragma mark - 添加向上按钮
-(void)addGoTopButton{
    [self.view addSubview:self.goTopBtn];
    [_goTopBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.bottom).offset(-60);
        make.height.equalTo(40);
        make.width.equalTo(40);
        make.right.equalTo(self.view.right).offset(-12);
    }];
}

#pragma mark - 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        SFFocusViewLayout *sfLayout = [[SFFocusViewLayout alloc] init];
        sfLayout.standardHeight = self.view.bounds.size.height/4.0;
        sfLayout.focusedHeight = self.view.bounds.size.height/2.0;

        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49) collectionViewLayout:sfLayout];
//        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
      
        [_collectionView registerNib:[UINib nibWithNibName:@"TopViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"topNews"];
    }


    return _collectionView;

}
-(UIButton *)goTopBtn{
    if (!_goTopBtn) {
        _goTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _goTopBtn.backgroundColor = [UIColor greenColor];
        [_goTopBtn addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
        [_goTopBtn setImage:[UIImage imageNamed:@"go_top"] forState:UIControlStateNormal];
  
        
    }
    
    return _goTopBtn;

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
