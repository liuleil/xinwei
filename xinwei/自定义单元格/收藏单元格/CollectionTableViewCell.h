//
//  CollectionTableViewCell.h
//  xinwei
//
//  Created by leileigege on 2017/2/28.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *from;

@end
