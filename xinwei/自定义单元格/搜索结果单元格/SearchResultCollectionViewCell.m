//
//  SearchResultCollectionViewCell.m
//  xinwei
//
//  Created by leileigege on 2017/2/26.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "SearchResultCollectionViewCell.h"

@implementation SearchResultCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}

@end
