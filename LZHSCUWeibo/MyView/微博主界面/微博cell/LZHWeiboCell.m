//
//  LZHWeiboCell.m
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/5/25.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHWeiboCell.h"


#define LZHScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LZHWeiboCell ()

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

@property (copy, nonatomic) NSString * wTimeString;

@property (copy, nonatomic) NSString * wSourceString;

@end

@implementation LZHWeiboCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [self loadUI];
    }
    return self;
}

//加载 cell 的视图
- (void) loadUI{
    UIView * cellContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LZHScreenWidth, 0)];
    [self.contentView addSubview:cellContentView];
    self.cellContentView = cellContentView;
    
    cellContentView.backgroundColor = [UIColor whiteColor];
    cellContentView.layer.masksToBounds = YES;
    
    [cellContentView addSubview:self.userSculptureView];
    [self setUserNickname:[NSString stringWithFormat:@"唐纳德川普"]];
    [cellContentView addSubview:self.userNicknameLabel];
    [cellContentView addSubview:self.timeAndSourceLabel];
    [self setWeiboDetail:[NSString stringWithFormat:@"一位胆大的英国老爸，自告奋勇带女儿班上60个同学去博物馆一日游…………这一天下来的心路历程……哈哈哈哈哈哈"]];
    [cellContentView addSubview:self.weiboDetailLabel];
    
    [cellContentView addSubview:self.weiboTabbar];
    
    //这句话一定要放在 loadUI 函数的最后位置!!!!
    CGFloat cHeight = CGRectGetMaxY(_weiboTabbar.frame);
    cellContentView.frame = CGRectMake(0, 0, LZHScreenWidth, cHeight);
    
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
//时间与数据源Label的 getter 方法
- (UILabel *)timeAndSourceLabel{
    if(!_timeAndSourceLabel){
        NSString * tempString = [NSString stringWithFormat:@"45分钟前 来自微博 weibo.com"];
        
        UIFont * font = [UIFont fontWithName:@"Heiti SC" size:11.0f];
        CGSize size = [tempString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
        
        _timeAndSourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, CGRectGetMaxY(_userNicknameLabel.frame)+5 , size.width, size.height)];
        [_timeAndSourceLabel setTextColor:[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1]];
        [_timeAndSourceLabel setFont:font];
        _timeAndSourceLabel.text = tempString;
    }
    
    return _timeAndSourceLabel;
}
//主微博文字Label的 getter 方法
- (UILabel *)weiboDetailLabel{
    if(!_weiboDetailLabel){
        _weiboDetailLabel = [[UILabel alloc] init];
        _weiboDetailLabel.numberOfLines = 0;
        _weiboDetailLabel.text = _weiboDetail;
        UIFont * font = [UIFont fontWithName:@"Heiti SC" size:16.5f];
        CGSize size = [_weiboDetailLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        _weiboDetailLabel.frame = CGRectMake(10, 64, size.width, size.height);
        [_weiboDetailLabel setFont:font];
    }
    
    return _weiboDetailLabel;
}
//微博脚标 view 的 getter 方法
- (UIView *)weiboTabbar{
    if(!_weiboTabbar){
        _weiboTabbar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weiboDetailLabel.frame)+10, [UIScreen mainScreen].bounds.size.width, 32)];
        //_weiboTabbar.backgroundColor = [UIColor redColor];
        UIView * splitLine = [[UIView alloc] initWithFrame:CGRectMake(14, 0, [UIScreen mainScreen].bounds.size.width-28, 0.25)];
        [splitLine setBackgroundColor:[UIColor grayColor]];
        [_weiboTabbar addSubview:splitLine];
        
        _commentsButton = [self buttonWithFrame:CGRectMake(0, 0, _weiboTabbar.frame.size.width/2, _weiboTabbar.frame.size.height) andImage:@"评论" andTitile:@"260"];
        [_weiboTabbar addSubview:_commentsButton];
        
        _thumbsupButton = [self buttonWithFrame:CGRectMake(_weiboTabbar.frame.size.width/2, 0, _weiboTabbar.frame.size.width/2, _weiboTabbar.frame.size.height) andImage:@"点赞" andTitile:@"1114"];
        [_weiboTabbar addSubview:_thumbsupButton];
        
    }
    
    return _weiboTabbar;
}

//创建一个带图标的 button
- (UIButton *) buttonWithFrame:(CGRect)frame andImage:(NSString *)imageName andTitile:(NSString *)labelText{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btn.frame = frame;
    
    UIFont * font = [UIFont fontWithName:@"Heiti SC" size:15.0f];
    CGSize size = [@"0000" boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    UILabel * centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    centerLabel.text = labelText;
    [centerLabel setFont:font];
    centerLabel.tag = 99;
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imgView.image = [UIImage imageNamed:imageName];
    
    UIView * centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imgView.frame.size.width + centerLabel.frame.size.width+10, imgView.frame.size.height)];
    [centerView addSubview:imgView];
    [centerLabel setCenter:CGPointMake(imgView.frame.size.width+10+centerLabel.frame.size.width/2, centerView.frame.size.height/2)];
    [centerView addSubview:centerLabel];
    [centerView setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
    centerView.tag = 98;
    
    [btn addSubview:centerView];
    
    return btn;
}

- (CGFloat)cellHeight{
    CGFloat cHeight = CGRectGetMaxY(_weiboTabbar.frame);
    return cHeight;
}

#pragma mark -重写的 set 方法,可以使数据改变的同时改变视图控件的参数
- (void)setUserNickname:(NSString *)userNickname{
    _userNickname = userNickname;
    _userNicknameLabel.text = userNickname;
    
    UIFont * font = [UIFont fontWithName:@"Heiti SC" size:13.6f];
    CGSize size = [_userNickname sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    _userNicknameLabel.frame = CGRectMake(64, 14, size.width, size.height);
}

- (void)setPublishedTime:(NSDate *)publishedTime{
    _publishedTime = publishedTime;
    
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    _wTimeString = currentDateString;
    _timeAndSourceLabel.text = [NSString stringWithFormat:@"%@  %@",_wTimeString, _wSourceString];
    
    UIFont * font = [UIFont fontWithName:@"Heiti SC" size:11.0f];
    CGSize size = [_timeAndSourceLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    _timeAndSourceLabel.frame = CGRectMake(64, CGRectGetMaxY(_userNicknameLabel.frame)+5 , size.width, size.height);
}

- (void)setPublishedSource:(NSString *)publishedSource{
    _publishedSource = publishedSource;
    _wSourceString = _publishedSource;
    
    _timeAndSourceLabel.text = [NSString stringWithFormat:@"%@  %@",_wTimeString, _wSourceString];
    UIFont * font = [UIFont fontWithName:@"Heiti SC" size:11.0f];
    CGSize size = [_timeAndSourceLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    _timeAndSourceLabel.frame = CGRectMake(64, CGRectGetMaxY(_userNicknameLabel.frame)+5 , size.width, size.height);
}

- (void)setWeiboDetail:(NSString *)weiboDetail{
    _weiboDetail = weiboDetail;
    _weiboDetailLabel.text = _weiboDetail;
    
    UIFont * font = [UIFont fontWithName:@"Heiti SC" size:16.5f];
    CGSize size = [_weiboDetailLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    _weiboDetailLabel.frame = CGRectMake(10, 64, size.width, size.height);
    
    //重置 tabbar 坐标
    _weiboTabbar.frame = CGRectMake(0, CGRectGetMaxY(self.weiboDetailLabel.frame)+10, [UIScreen mainScreen].bounds.size.width, 32);
    //重置 cell 的 contentView 坐标
    CGFloat cHeight = CGRectGetMaxY(_weiboTabbar.frame);
    _cellContentView.frame = CGRectMake(0, 0, LZHScreenWidth, cHeight);
}

- (void)setCommentsNumber:(NSInteger)commentsNumber{
    _commentsNumber = commentsNumber;
    UILabel * commentLabel = (UILabel *)[[_commentsButton viewWithTag:98] viewWithTag:99];
    commentLabel.text = [NSString stringWithFormat:@"%ld", (long)_commentsNumber];
}

- (void)setThumbsupNumber:(NSInteger)thumbsupNumber{
    _thumbsupNumber = thumbsupNumber;
    UILabel * thumbsupLabel = (UILabel *)[[_thumbsupButton viewWithTag:98] viewWithTag:99];
    thumbsupLabel.text = [NSString stringWithFormat:@"%ld", (long)_thumbsupNumber];
}

@end
/*
 
每一个 set 方法都需要重写.

@property (strong, nonatomic) UIImage * userSculpture;

@property (copy, nonatomic) NSString * userNickname;

@property (strong, nonatomic) NSDate * publishedTime;

@property (copy, nonatomic) NSString * publishedSource;

@property (copy, nonatomic) NSString * weiboDetail;

@property (assign, nonatomic) NSInteger * commentsNumber;

@property (assign, nonatomic) NSInteger * thumbsupNumber;
 */
