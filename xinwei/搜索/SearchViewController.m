//
//  SearchViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/22.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultViewController.h"
#import "NewsTableViewCell.h"
#import <DKNightVersion/DKNightVersion.h>
#import <SVProgressHUD.h>
#import "CQRootClass.h"
#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface SearchViewController ()<UISearchResultsUpdating,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISearchController *seachCon;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) CQRootClass *newsModel;
@property(nonatomic,strong) SearchResultViewController *result;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
//    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
//    DKNightVersionManager *manager = [DKNightVersionManager sharedManager];
    
//    manager.themeVersion = DKThemeVersionNight;
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
[_tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil]  forCellReuseIdentifier:@"newsCell"];

    //注册通知,收到通知以后调用当前对象的selector方法,通知的名称,指定可以接收到谁的通知,如果为nil就表示任何人都能发通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendRequest:) name:@"110" object:nil];
    self.navigationItem.title = @"新闻搜索";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    self.result = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
    
    //1 当前视图控制器在导航器中,模态到b,如果设置了这个属性,b的presenting就是它,如果为NO,就是导航器
    //2 模态的尺寸有当前视图控制器决定
    self.definesPresentationContext = YES;
    _seachCon = [[UISearchController alloc] initWithSearchResultsController:self.result];
    _seachCon.searchResultsUpdater = self;
    //点击scope调用方法
    _seachCon.searchBar.delegate = self;
    _seachCon.searchBar.placeholder = @"搜索新闻";

    //当设置了searchBar的scopeButtonTitles的时候,系统会自动给设置大小屏幕宽高是44,如果不设置的话默认是宽高是0,需要手动设置
//    _seachCon.searchBar.scopeButtonTitles = @[@"按中文",@"按英文"];
    self.tableView.tableHeaderView = _seachCon.searchBar;
}
#pragma mark - UISearchResultsUpdating
//此方法是必须实现的方法
//当searchBar获取光标的时候,文本内容发生改变的时候会调用,官方文档中说的点击scopeButton会调用,其实不会,我们可以设置searchBar的委托实现点击scopeButton的事件
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    [self filterData:searchController.searchBar.text andScopIndex:searchController.searchBar.selectedScopeButtonIndex];
    //当搜索栏中没有内容的时候默认是隐藏掉的
    _seachCon.searchResultsController.view.hidden = NO;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
 [[NSNotificationCenter defaultCenter] postNotificationName:@"sendRequest" object:searchBar.text userInfo:nil];
 

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [SVProgressHUD dismiss];
    if (self.result.newsModel) {
        self.newsModel = self.result.newsModel;
        [self.tableView reloadData];
    }
    
    

}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.newsModel.result.list.count;
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



#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;

}
#pragma mark - 懒加载



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
