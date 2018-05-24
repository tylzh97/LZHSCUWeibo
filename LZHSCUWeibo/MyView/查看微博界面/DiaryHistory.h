//
//  DiaryHistory.h
//  MyDiary
//
//  Created by 李政浩 on 2018/5/8.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "DiaryHistoryViewCell.h"
#import "floatView.h"

#import "MJRefresh.h"

@interface DiaryHistory : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) AppDelegate * appDelegate;

//@property (strong, nonatomic) UIView * visiableView;
@property (strong, nonatomic) UITableView * mainTableView;

@property (strong, nonatomic) NSMutableArray *data;

@end
