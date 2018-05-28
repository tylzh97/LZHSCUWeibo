//
//  WeiboViewController.h
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/5/25.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "LZHWeiboCell.h"

#import "LZHJsonEncoder.h"

#import "lzhHash.h"

#import "MJRefresh.h"

@interface WeiboViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) AppDelegate * appDelegate;

//@property (strong, nonatomic) UIView * visiableView;
@property (strong, nonatomic) UITableView * mainTableView;

@property (strong, nonatomic) NSMutableArray *data;

@end
