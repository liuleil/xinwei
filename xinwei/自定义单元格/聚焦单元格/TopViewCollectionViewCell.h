//
//  TopViewCollectionViewCell.h
//  xinwei
//
//  Created by leileigege on 2017/2/25.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopViewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;

@end
