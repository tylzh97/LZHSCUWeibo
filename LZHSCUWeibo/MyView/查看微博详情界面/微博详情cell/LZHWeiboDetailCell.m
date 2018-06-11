//
//  LZHWeiboDetailCell.m
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/8.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHWeiboDetailCell.h"

#define LZHScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LZHWeiboDetailCell ()

@end

@implementation LZHWeiboDetailCell

//初始化方法,需要传入重用ID
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [self loadUI];
    }
    return self;
}

//加载 cell 的视图的自定义方法
- (void) loadUI{
    //cell主视图
    UIView * cellContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LZHScreenWidth, 0)];
    [self.contentView addSubview:cellContentView];
    self.cellContentView = cellContentView;
    //设置cell主视图属性
    cellContentView.backgroundColor = [UIColor whiteColor];
    cellContentView.layer.masksToBounds = YES;
    
    //添加头像
    [cellContentView addSubview:self.userSculptureView];
    //设置用户昵称
    [self setUserNickname:[NSString stringWithFormat:@"唐纳德川普"]];
    //添加用户昵称标签
    [cellContentView addSubview:self.userNicknameLabel];
    //设置评论内容
    [self setCommentDetail:[NSString stringWithFormat:@"一位胆大的英国老爸，自告奋勇带女儿班上60个同学去博物馆一日游…………这一天下来的心路历程……哈哈哈哈哈哈"]];
    //添加评论标签
    [cellContentView addSubview:self.commentDetailLabel];
    //添加时间标签
    [cellContentView addSubview:self.timeLabel];
    
    //这句话一定要放在 loadUI 函数的最后位置!!!!
    CGFloat cHeight = CGRectGetMaxY(_timeLabel.frame);
    cellContentView.frame = CGRectMake(0, 0, LZHScreenWidth, cHeight);
    
}

//删除按钮的getter方法
- (UIButton *)delButton{
    if(!_delButton){
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        _delButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        CGFloat buttonL = 25;
        CGPoint buttonO = CGPointMake(screenSize.width-buttonL-10, 10);
        _delButton.frame = CGRectMake(buttonO.x, buttonO.y, buttonL, buttonL);
        [_delButton setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_delButton addTarget:self action:@selector(delTrigger) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return  _delButton;
}

- (void) delTrigger{
    NSLog(@"点了删除");
    [self.delCommentDelegate delCommentWithCommentID:self.commentID andWeiboID:self.weiboID andWeiboDetail:self.commentDetail];
}

//用户头像界面的 getter 方法
- (UIImageView *)userSculptureView{
    if(!_userSculptureView){
        _userSculptureView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 40, 40)];
        _userSculptureView.image = [UIImage imageNamed:@"akua"];
        [_userSculptureView.layer setCornerRadius:20];
        [_userSculptureView.layer setBorderWidth:1];
        [_userSculptureView.layer setBorderColor:[UIColor grayColor].CGColor];
        _userSculptureView.layer.masksToBounds = YES;
    }
    
    return _userSculptureView;
}
//用户昵称Label 的 getter 方法
- (UILabel *)userNicknameLabel{
    if(!_userNicknameLabel){
        //_userNicknameLabel = [UILabel alloc]
        UIFont * font = [UIFont fontWithName:@"Heiti SC" size:13.6f];
        CGSize size = [_userNickname sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
        
        _userNicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 14, size.width, size.height)];
        [_userNicknameLabel setTextColor:[UIColor colorWithRed:235/255.0 green:112/255.0 blue:48/255.0 alpha:1]];
        [_userNicknameLabel setFont:font];
        _userNicknameLabel.text = _userNickname;
    }
    
    return _userNicknameLabel;
}

//主微博文字Label的 getter 方法
- (UILabel *)commentDetailLabel{
    if(!_commentDetailLabel){
        _commentDetailLabel = [[UILabel alloc] init];
        _commentDetailLabel.numberOfLines = 0;
        _commentDetailLabel.text = _commentDetail;
        UIFont * font = [UIFont fontWithName:@"Heiti SC" size:16.5f];
        CGSize size = [_commentDetailLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 74, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _commentDetailLabel.frame = CGRectMake(64, CGRectGetMaxY(_userNicknameLabel.frame)+5, size.width, size.height);
        [_commentDetailLabel setFont:font];
    }
    
    return _commentDetailLabel;
}

//时间Label的 getter 方法
- (UILabel *)timeLabel{
    if(!_timeLabel){
        NSString * tempString = [NSString stringWithFormat:@"2018-06-09 12:52:06"];
        
        UIFont * font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
        CGSize size = [tempString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, CGRectGetMaxY(_commentDetailLabel.frame)+10 , size.width, size.height)];
        [_timeLabel setTextColor:[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1]];
        [_timeLabel setFont:font];
        _timeLabel.text = tempString;
    }
    
    return _timeLabel;
}



//获取cell高度
////////////////////////////////////////////////////////
- (CGFloat)cellHeight{
    CGFloat cHeight = CGRectGetMaxY(_timeLabel.frame);
    return cHeight;
}

#pragma mark -重写的 set 方法,可以使数据改变的同时改变视图控件的参数
//设置用户名
- (void)setUserID:(NSInteger)userID{
    _userID = userID;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger localUserID = [[defaults objectForKey:@"userID"] intValue];
    
    if(localUserID == userID){
        _delButton.hidden = NO;
        [self.cellContentView addSubview:self.delButton];
    }
    else{
        _delButton.hidden = YES;
    }
}

//设置用户名
- (void)setUserNickname:(NSString *)userNickname{
    _userNickname = userNickname;
    _userNicknameLabel.text = userNickname;
    
    UIFont * font = [UIFont fontWithName:@"Heiti SC" size:13.6f];
    CGSize size = [_userNickname sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    _userNicknameLabel.frame = CGRectMake(64, 14, size.width, size.height);
}


//设置微博详情
- (void)setCommentDetail:(NSString *)weiboDetail{
    _commentDetail = weiboDetail;
    _commentDetailLabel.text = _commentDetail;
    
    UIFont * font = [UIFont fontWithName:@"Heiti SC" size:16.5f];
    CGSize size = [_commentDetailLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 74, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    _commentDetailLabel.frame = CGRectMake(64, CGRectGetMaxY(_userNicknameLabel.frame)+5, size.width, size.height);
    
    //重置 tabbar 坐标
    _timeLabel.frame = CGRectMake(64, CGRectGetMaxY(_commentDetailLabel.frame)+10, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    //重置 cell 的 contentView 坐标
    CGFloat cHeight = CGRectGetMaxY(_timeLabel.frame);
    _cellContentView.frame = CGRectMake(0, 0, LZHScreenWidth, cHeight);
}

//设置评论时间
- (void)setPublishedTime:(NSString *)publishedTime{
    _publishedTime = publishedTime;
    _timeLabel.text = _publishedTime;
    
    NSString * tempString = _publishedTime;
    
    UIFont * font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
    CGSize size = [tempString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, CGRectGetMaxY(_commentDetailLabel.frame)+10 , size.width, size.height)];
    [_timeLabel setTextColor:[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1]];
    [_timeLabel setFont:font];
    
    //重置 cell 的 contentView 坐标
    CGFloat cHeight = CGRectGetMaxY(_timeLabel.frame);
    _cellContentView.frame = CGRectMake(0, 0, LZHScreenWidth, cHeight);
}



@end


