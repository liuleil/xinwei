//
//  SourceViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/27.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "SourceViewController.h"

@interface SourceViewController ()

@end

@implementation SourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
    self.automaticallyAdjustsScrollViewInsets = NO;
           NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
        [self.webView loadRequest:request];
}

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
