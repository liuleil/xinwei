//
//  CollectionTableViewCell.m
//  xinwei
//
//  Created by leileigege on 2017/2/28.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "CollectionTableViewCell.h"

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
