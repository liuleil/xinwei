//
//  TabbarCollectionCell.m
//  xinwei
//
//  Created by leileigege on 2017/2/23.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "TabbarCollectionCell.h"

@implementation TabbarCollectionCell
- (void)setSubVc:(UIViewController *)subVc{
    
    _subVc = subVc;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:subVc.view];
    subVc.view.frame = self.bounds;
}
@end
