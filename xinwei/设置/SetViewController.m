//
//  SetViewController.m
//  xinwei
//
//  Created by leileigege on 2017/2/22.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.v1.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.v2.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BG);
}
- (IBAction)changeColor:(UISwitch *)sender {
    if (sender.on == YES) {
            DKNightVersionManager *manager = [DKNightVersionManager sharedManager];
            manager.themeVersion = DKThemeVersionNight;
    }
    else{
        DKNightVersionManager *manager = [DKNightVersionManager sharedManager];
        manager.themeVersion = DKThemeVersionNormal;
    
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
