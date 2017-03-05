//
//  SearchResultViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/22.
//  Copyright © 2017年 liulei. All rights reserved.
//
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#import "SearchResultViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "SearchResultCollectionViewCell.h"
#import "RequestBase+SearchNews.h"

#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
@interface SearchResultViewController ()<UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property(nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray *cellSizes;

@end

@implementation SearchResultViewController
#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
      self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
//    self.automaticallyAdjustsScrollViewInsets = YES;
//
//    注册通知,收到通知以后调用当前对象的selector方法,通知的名称,指定可以接收到谁的通知,如果为nil就表示任何人都能发通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendRequest:) name:@"sendRequest" object:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.newsModel.result.list count];

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"resultCell" forIndexPath:indexPath];
    cell.newsTitle.text = (NSString *)[self.newsModel.result.list[indexPath.row] title];
    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:[self.newsModel.result.list[indexPath.row] pic]] placeholderImage:[UIImage imageNamed:@"placeHold"]];
   
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 return [self.cellSizes[indexPath.item % 4] CGSizeValue];

}
#pragma mark - 请求
-(void)sendRequest:(NSNotification *)notification{
    //    提示框显示
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
    //    请求
    [RequestBase sendRequstWithKeyword:(NSString *)notification.object completionHandler:^(id responseObj, NSError *error) {
    if (!error) {
        self.newsModel =(CQRootClass *) responseObj;
        NSLog(@"%@",[self.newsModel.result.list[1] title]);
        
        if (!_collectionView) {
             [self.view addSubview:self.collectionView];
        }
        else{
            [self.collectionView reloadData];
        
        }
        [SVProgressHUD dismiss];
    }
    else{
        [SVProgressHUD dismiss];
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络错误或者没有结果" preferredStyle:1];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCon addAction:cancelAction];
        [self presentViewController:alertCon animated:YES completion:nil];
        
    }

}];








}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//
//}
#pragma mark - 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        

        layout.minimumColumnSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.columnCount = 3;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
   
        
        [_collectionView registerNib:[UINib nibWithNibName:@"SearchResultCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"resultCell"];
    }



    return _collectionView;
}
- (NSArray *)cellSizes {
    if (!_cellSizes) {
        _cellSizes = @[
                       [NSValue valueWithCGSize:CGSizeMake(400, 550)],
                       [NSValue valueWithCGSize:CGSizeMake(1000, 665)],
                       [NSValue valueWithCGSize:CGSizeMake(1024, 689)],
                       [NSValue valueWithCGSize:CGSizeMake(640, 427)]
                     
                       ];
    }
    return _cellSizes;
}
@end
