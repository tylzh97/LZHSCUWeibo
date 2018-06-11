//
//  LZHWeiboDetailCell.h
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/8.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DelCommentDelegate<NSObject>
@required
//点击删除后的代理
- (void) delCommentWithCommentID:(NSInteger)commentID andWeiboID:(NSInteger) weiboID andWeiboDetail:(NSString *) weiboDetail;
@end

@interface LZHWeiboDetailCell : UITableViewCell

@property (strong, nonatomic) id<DelCommentDelegate> delCommentDelegate;

/**用户头像*/
@property (strong, nonatomic) UIImage * userSculpture;
/**用户昵称*/
@property (copy, nonatomic) NSString * userNickname;
/**评论公布时间*/
@property (strong, nonatomic) NSString * publishedTime;
/**评论详情*/
@property (copy, nonatomic) NSString * commentDetail;
/**评论cell高度*/
@property (assign, nonatomic) CGFloat cellHeight;
/************************************************************************************************************/
/**用户头像 View*/
@property (strong, nonatomic) UIImageView * userSculptureView;
/**用户昵称标签*/
@property (strong, nonatomic) UILabel * userNicknameLabel;
/**时间标签*/
@property (strong, nonatomic) UILabel * timeLabel;
/**评论详情标签*/
@property (strong, nonatomic) UILabel * commentDetailLabel;
/**微博 cell 的界面*/
@property (strong, nonatomic) UIView * cellContentView;
/**删除评论按钮*/
@property (strong, nonatomic) UIButton * delButton;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**本条cell对应的微博的微博ID*/
@property (assign, nonatomic) NSInteger weiboID;
/**本条评论的ID*/
@property (assign, nonatomic) NSInteger commentID;
/**用户ID*/
@property (assign, nonatomic) NSInteger userID;

@end



