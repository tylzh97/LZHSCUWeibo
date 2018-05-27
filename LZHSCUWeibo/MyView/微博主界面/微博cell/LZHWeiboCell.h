//
//  LZHWeiboCell.h
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/5/25.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LZHWeiboCell : UITableViewCell

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

@property (assign, nonatomic) CGFloat cellHeight;

@end
