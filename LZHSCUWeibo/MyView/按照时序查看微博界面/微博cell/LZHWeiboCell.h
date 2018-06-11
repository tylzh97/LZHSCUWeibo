//
//  LZHWeiboCell.h
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/5/25.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lzhHash.h"
#import "LZHJsonEncoder.h"


@protocol DelWeiboDelegate<NSObject>
@required
//点击删除后的代理
- (void) delWeibo:(NSInteger) weiboID andWeiboDetail:(NSString *) weiboDetail;
@end

@interface LZHWeiboCell : UITableViewCell <NSURLConnectionDataDelegate>

@property (strong, nonatomic) id<DelWeiboDelegate> delDelegate;


/**用户头像*/
@property (strong, nonatomic) UIImage * userSculpture;
/**用户昵称*/
@property (copy, nonatomic) NSString * userNickname;
/**本条微博公布时间*/
@property (strong, nonatomic) NSDate * publishedTime;
/**本条微博来源*/
@property (copy, nonatomic) NSString * publishedSource;
/**微博详情*/
@property (copy, nonatomic) NSString * weiboDetail;
/**评论数*/
@property (assign, nonatomic) NSInteger commentsNumber;
/**点赞数*/
@property (assign, nonatomic) NSInteger thumbsupNumber;
/**微博cell高度*/
@property (assign, nonatomic) CGFloat cellHeight;
/************************************************************************************************************/
/**用户头像 View*/
@property (strong, nonatomic) UIImageView * userSculptureView;
/**用户昵称标签*/
@property (strong, nonatomic) UILabel * userNicknameLabel;
/**时间与来源标签*/
@property (strong, nonatomic) UILabel * timeAndSourceLabel;
/**微博详情标签*/
@property (strong, nonatomic) UILabel * weiboDetailLabel;
/**微博脚标 View*/
@property (strong, nonatomic) UIView * weiboTabbar;
/**微博脚标:评论按钮*/
@property (strong, nonatomic) UIButton * commentsButton;
/** 微博脚标:点赞按钮*/
@property (strong, nonatomic) UIButton * thumbsupButton;
/**微博 cell 的界面*/
@property (strong, nonatomic) UIView * cellContentView;

@property (strong, nonatomic) UIButton * delButton;

@property (copy, nonatomic) NSString * wTimeString;

@property (copy, nonatomic) NSString * wSourceString;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**本条cell存储的微博的微博ID*/
@property (assign, nonatomic) NSInteger weiboID;

@property (assign, nonatomic) NSInteger userID;

- (void) setSelfWithLZHWeiboCell:(LZHWeiboCell *) aCell;

/**用于判断本条微博是否点赞*/
@property (assign, nonatomic) BOOL haveLiked;

@end



