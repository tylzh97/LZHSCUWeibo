//
//  weiboDetailViewController.h
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/7.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZHWeiboCell.h"
#import "LZHWeiboDetailCell.h"
#import "lzhHash.h"
#import "LZHJsonEncoder.h"
#import "LZHAddCommentViewController.h"

@interface weiboDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate, DelCommentDelegate>
//微博详情TableView
@property (strong, nonatomic) UITableView * detailTableView;
/**评论数据源*/
@property (strong, nonatomic) NSMutableArray * commentSource;
/**原微博cell指针*/
@property (strong, nonatomic) LZHWeiboCell * weiboSourceCell;
/**该详情对应的微博ID*/
@property (assign, nonatomic) NSInteger weiboID;
/**评论数组,该数组为实际上使用的数组*/
@property (strong, nonatomic) NSMutableArray * lzhCommentArray;
/**用于判断评论数是否为0*/
@property (assign, nonatomic) BOOL isCommentNumberEqualToZero;

/**微博脚标 View*/
@property (strong, nonatomic) UIView * weiboTabbar;
/**微博脚标:评论按钮*/
@property (strong, nonatomic) UIButton * commentsButton;
/** 微博脚标:点赞按钮*/
@property (strong, nonatomic) UIButton * thumbsupButton;

/**评论数*/
@property (assign, nonatomic) NSInteger commentNumber;
/**点赞数*/
@property (assign, nonatomic) NSInteger likeNumber;

/**分界线评论按钮*/
@property (strong, nonatomic) UIButton * splitCommentButton;
/**分界线点赞按钮*/
@property (strong, nonatomic) UIButton * splitLikeButton;

@end
