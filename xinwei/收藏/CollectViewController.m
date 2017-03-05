//
//  CollectViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/22.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "CollectViewController.h"
#import "DataBase.h"
#import "CQList.h"
#import "CollectionTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "NewDetailViewController.h"
@interface CollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);

    
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *arr = [DataBase queryTable];
    self.dataArr = nil;
    self.dataArr = [[NSMutableArray alloc]initWithArray:arr];
    [self.tableView reloadData];


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.dataArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.title.text = [self.dataArr[indexPath.row] title];
    cell.from.text = [self.dataArr[indexPath.row] src];
    cell.time.text = (NSString *)[self.dataArr[indexPath.row] time];
    [cell.newsImage sd_setImageWithURL:[NSURL URLWithString:[self.dataArr[indexPath.row] pic]] placeholderImage:[UIImage imageNamed:@"beijing.jpg"]];
      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
          [self deleteWithNewsTitle:[self.dataArr[indexPath.row] title]];
        NSLog(@"---------%@",[self.dataArr[indexPath.row] url]);
        [self.dataArr removeObjectAtIndex:indexPath.row];
   
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
     
        
    }];
    
    return @[deleteAction];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NewDetailViewController *newDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewDetailViewController"];
    newDetailViewController.cq_new_list = self.dataArr[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newDetailViewController animated:YES];
    self.hidesBottomBarWhenPushed=NO;




}
-(void)deleteWithNewsTitle:(NSString *)title{
    [DataBase deleteNews:title];
    
    
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
