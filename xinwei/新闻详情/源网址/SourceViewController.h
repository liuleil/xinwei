//
//  SourceViewController.h
//  xinwei
//
//  Created by leileigege on 2017/2/27.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SourceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,copy) NSString *urlStr;
@end
