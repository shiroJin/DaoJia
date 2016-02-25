//
//  WebViewCell.h
//  DaoJia
//
//  Created by Macx on 16/2/15.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, copy)NSString *url;

@end
