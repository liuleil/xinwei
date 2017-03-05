//
//  TopViewCollectionViewCell.m
//  xinwei
//
//  Created by leileigege on 2017/2/25.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "TopViewCollectionViewCell.h"

@implementation TopViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

@end
