//
//  NewDetailViewController.h
//  xinwei
//
//  Created by leileigege on 2017/2/27.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQList.h"
@interface NewDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong) CQList *cq_new_list;
@end
