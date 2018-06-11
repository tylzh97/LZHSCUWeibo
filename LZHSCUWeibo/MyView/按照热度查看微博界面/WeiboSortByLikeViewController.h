//
//  WeiboSortByLikeViewController.h
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/6.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "LZHWeiboCell.h"

#import "LZHJsonEncoder.h"

#import "lzhHash.h"

#import "MJRefresh.h"

@interface WeiboSortByLikeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

/**获取应用委托*/
@property (strong, nonatomic) AppDelegate * appDelegate;
/**主Table视图*/
@property (strong, nonatomic) UITableView * mainTableView;
/**视图中的数据*/
@property (strong, nonatomic) NSMutableArray *data;

@end
