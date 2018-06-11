//
//  weiboDetailViewController.m
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/7.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "weiboDetailViewController.h"

#define NUMBER_OF_SECTION 2

@interface weiboDetailViewController ()

@property (strong, nonatomic) NSMutableData * recvData;

@end

@implementation weiboDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.recvData = [[NSMutableData alloc] init];
    
    //设置为0条评论
    self.isCommentNumberEqualToZero = YES;

}

- (void)viewDidAppear:(BOOL)animated{
    //当界面出现时,发送加载评论网络请求.
    [super viewDidAppear:animated];
    
    [self requestServerForComment];
}

- (void) requestServerForComment{
    NSString *currTime = [self getCurrTimeString];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * httpAddress = [defaults objectForKey:@"HTTPAddress"];
    //checkComments?userID=[用户id]&time=[时间]&check=[验证码]&weiboID=[微博编号]
    
    //NSString * localUserName = [defaults objectForKey:@"userName"];
    NSString * localUserID = [defaults objectForKey:@"userID"];
    
    NSString * strUrl = [NSString stringWithFormat:@"%@/checkComments?userID=%@&time=%@&check=%@&weiboID=%d", httpAddress, localUserID , currTime, [self getCheckCodeWithRequest:@"checkComments" andTime:currTime], self.weiboID ];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
    [NSURLConnection connectionWithRequest:request delegate:self];

}


- (NSString *) getCurrTimeString{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    return currentDateString;
}

- (NSString *) getCheckCodeWithRequest:(NSString *)request andTime:(NSString *)timeStr{
    NSString *checkCode = [lzhHash md5:[NSString stringWithFormat:@"%@%@", request, timeStr]];
    checkCode = [lzhHash md5:[checkCode substringFromIndex:[checkCode length]-5]];
    return [checkCode uppercaseString];
}

- (void) loadUI{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //创建Table
    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height-50) style:UITableViewStylePlain];
    //设置Table的背景色为微博主题浅灰色
    self.detailTableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self.view addSubview:self.detailTableView];
    
    [self.view addSubview:self.weiboTabbar];
    
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    
    
}

//微博脚标 view 的 getter 方法
- (UIView *)weiboTabbar{
    if(!_weiboTabbar){
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        _weiboTabbar = [[UIView alloc] initWithFrame:CGRectMake(0, screenSize.height-48, screenSize.width, 48)];
        _weiboTabbar.backgroundColor = [UIColor whiteColor];
        UIView * splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 0.5)];
        [splitLine setBackgroundColor:[UIColor grayColor]];
        [_weiboTabbar addSubview:splitLine];
        
        _commentsButton = [self buttonWithFrame:CGRectMake(0, 0, _weiboTabbar.frame.size.width/2, _weiboTabbar.frame.size.height) andImage:@"评论" andTitile:@"评论"];
        [_weiboTabbar addSubview:_commentsButton];
        [_commentsButton addTarget:self action:@selector(commentPushed) forControlEvents:UIControlEventTouchUpInside];
        //[_commentsButton setBackgroundColor:[UIColor redColor]];
        
        _thumbsupButton = [self buttonWithFrame:CGRectMake(_weiboTabbar.frame.size.width/2, 0, _weiboTabbar.frame.size.width/2, _weiboTabbar.frame.size.height) andImage:@"点赞" andTitile:@"点赞"];
        [_weiboTabbar addSubview:_thumbsupButton];
        [_thumbsupButton addTarget:self action:@selector(likePushed) forControlEvents:UIControlEventTouchUpInside];
        //[_thumbsupButton setBackgroundColor:[UIColor greenColor]];
        
    }
    
    return _weiboTabbar;
}

- (void) commentPushed{
    NSLog(@"要评论%ld", (long)self.weiboID);
    LZHAddCommentViewController * lzhAdd = [[LZHAddCommentViewController alloc] init];
    lzhAdd.weiboID = self.weiboID;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:lzhAdd];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void) likePushed{
    NSLog(@"点赞了%ld", (long)self.weiboID);
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
    //设置为不接受点按事件,既将点按事件传递到该图层下方
    //该属性的默认值方法为YES
    centerView.userInteractionEnabled = NO;
    
    //centerView.backgroundColor = [UIColor orangeColor];
    
    [btn addSubview:centerView];
    
    return btn;
}

#pragma mark -DelCommentDelegate的委托方法
- (void)delCommentWithCommentID:(NSInteger)commentID andWeiboID:(NSInteger)weiboID andWeiboDetail:(NSString *)weiboDetail{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"删除微博" message:weiboDetail preferredStyle:UIAlertControllerStyleActionSheet];
    
    //UIAlertActionStyleDefault 普通蓝色字体
    UIAlertAction *confirmDelete = [UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定删除微博:%d", weiboID);
        [self delCommentWithCommentID:commentID andWeiboID:weiboID];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:confirmDelete];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
    

- (void) delCommentWithCommentID:(NSInteger) commentID andWeiboID:(NSInteger) weiboID{
    
    NSMutableData * delRecallData = [[NSMutableData alloc] init];
    
    NSString *currTime = [self getCurrTimeString];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * httpAddress = [defaults objectForKey:@"HTTPAddress"];
    NSString * localUserID = [defaults objectForKey:@"userID"];
    
    NSString * strUrl = [NSString stringWithFormat:@"%@/deleteComment?userID=%@&time=%@&check=%@&commentID=%d&weiboID=%d", httpAddress, localUserID , currTime, [self getCheckCodeWithRequest:@"deleteComment" andTime:currTime], commentID, weiboID ];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //NSMutableData * dislikeData = data;
        NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString * jsonStr = [NSString stringWithFormat:@"%@",text];
        [self checkDeleteData:jsonStr];
    }];
}

- (void) checkDeleteData:(NSString *) str{
    NSDictionary * jsonDic = [LZHJsonEncoder dictionaryWithJsonString:str andSource:@"weiboViewController -5"];
    NSString * response = [NSString stringWithFormat:@"%@", [jsonDic objectForKey:@"response"]];
    NSDictionary * responseDic = [LZHJsonEncoder dictionaryWithJsonString:response andSource:@"weiboViewController -6"];
    NSString * isSucceed = [NSString stringWithFormat:@"%@", [responseDic objectForKey:@"isSuccess"]];
    if([isSucceed isEqualToString:@"TRUE"]){
        NSLog(@"评论删除成功");
        [self requestServerForComment];
    }
    
}



#pragma mark -UITableViewDataSource的委托方法
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    //微博详情cell
    if(indexPath.section == 0){
        LZHWeiboCell * detailCell = [tableView dequeueReusableCellWithIdentifier:@"weiboDetailCell"];
        if (!detailCell)
        {
            detailCell = [[LZHWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weiboDetailCell"];
            [detailCell setSelfWithLZHWeiboCell:self.weiboSourceCell];
            detailCell.weiboTabbar.hidden = true;
        }
        detailCell.userInteractionEnabled = NO;
        return detailCell;
    }
    
    else if(self.isCommentNumberEqualToZero){
        //[cell setText:@"还没有评论哦~"];
        
        UILabel * cellLabel =[[UILabel alloc] initWithFrame:cell.frame];
        cellLabel.text = @"还没有评论哦~";
        cellLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:cellLabel];
        
        cell.userInteractionEnabled = NO;
        return cell;
    }
    
    //评论cell
    else if(indexPath.section == 1){
        LZHWeiboDetailCell * commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
        if(!commentCell){
            commentCell = [[LZHWeiboDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentCell"];
        }
        
        commentCell.delCommentDelegate = self;
        
        NSMutableDictionary * currComment = self.lzhCommentArray[indexPath.row];
        
        [commentCell setUserNickname:[currComment objectForKey:@"userName"]];
        [commentCell setCommentDetail:[currComment objectForKey:@"commentDetail"]];
        [commentCell setPublishedTime:[currComment objectForKey:@"commentTime"]];
        [commentCell setWeiboID:[[currComment objectForKey:@"weiboID"] intValue]];
        [commentCell setCommentID:[[currComment objectForKey:@"commentID"] intValue]];
        [commentCell setUserID:[[currComment objectForKey:@"userID"] intValue]];
        
        /*
        [commentCell setUserNickname:@"DonaldTrump"];
        [commentCell setCommentDetail:@"哈哈哈哈哈,测试,哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈你好测试哈哈哈!"];
        [commentCell setPublishedTime:@"2018-06-09 12:52:06"];
        [commentCell setWeiboID:1];
        [commentCell setCommentID:1];
        */
        
        return commentCell;
    }
    
    return cell;
}

//用于设置每个section的cell个数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else{
        NSInteger commentNumber = self.lzhCommentArray.count;
        if (commentNumber == 0) {
            //若没有评论,则留一个cell将评论设置为"无评论"字样
            return 1;
            self.isCommentNumberEqualToZero = YES;
        }
        self.isCommentNumberEqualToZero = NO;
        return commentNumber;
        //return 55;
        //return self.commentSource.count;
    }
}

#pragma mark -UITableViewDelegate的委托方法
//当某行被选中时,会触发此方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//用于设置每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0;
    if(indexPath.section == 0){
        //cellHeight = 80;
        cellHeight = self.weiboSourceCell.cellHeight - self.weiboSourceCell.weiboTabbar.frame.size.height;
    }
    else{
        if (self.isCommentNumberEqualToZero) {
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            //cell的高度设置为 屏幕高度,
            cellHeight = screenSize.height-self.weiboSourceCell.cellHeight-[self tableView:tableView viewForHeaderInSection:indexPath.section].frame.size.height;
        }
        else{
            LZHWeiboDetailCell * commentCell = (LZHWeiboDetailCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            cellHeight = commentCell.cellHeight;
        }
    }
    return cellHeight;
}

//用于设置table的section个数.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return NUMBER_OF_SECTION;
}

//用于设置每个section的header的高度
//当table模式为UITableViewStylePlain时,计数从0开始.
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat headerHeight = 0;
    if (section == 0) {
        headerHeight = 0;
    }
    else if (section == 1){
        headerHeight = [self tableView:tableView viewForHeaderInSection:section].bounds.size.height;
    }
    return headerHeight;
}
//用于设置每个Section的Footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat footerHeight = 0.0f;
    if(section == 0){
        footerHeight = [self tableView:tableView viewForFooterInSection:section].frame.size.height;
    }
    else{
        footerHeight = 0.0f;
    }
    return footerHeight;
}

//用于设置每个section的headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(-1, -1, screenSize.width+2, 50)];
    
    if(section == 0){
        headerView.backgroundColor = [UIColor clearColor];
    }
    else if (section == 1){
        headerView.backgroundColor = [UIColor whiteColor];
        UIView * splitView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-1, screenSize.width, 1)];
        splitView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [headerView addSubview:splitView];
        //评论按钮
        UIButton * commentBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        commentBtn.frame = CGRectMake(10, 0, 80, headerView.frame.size.height);
        [commentBtn setTitle:[NSString stringWithFormat:@"评论 %d", self.commentNumber] forState:UIControlStateNormal];
        [commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [headerView addSubview:commentBtn];
        self.splitCommentButton = commentBtn;
        //[commentBtn setBackgroundColor:[UIColor redColor]];
        //点赞按钮
        UIButton * likeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        likeBtn.frame = CGRectMake(screenSize.width-80-10, 0, 80, headerView.frame.size.height);
        [likeBtn setTitle:[NSString stringWithFormat:@"点赞 %d", self.likeNumber] forState:UIControlStateNormal];
        [likeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [headerView addSubview:likeBtn];
        self.splitLikeButton = likeBtn;
        //[likeBtn setBackgroundColor:[UIColor redColor]];
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 30)];
    if(section == 0){
        [footerView setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]];
        
    }
    else{
        [footerView setFrame:CGRectMake(0, 0, 0, 0 )];
        [footerView setBackgroundColor:[UIColor clearColor]];
    }
    return footerView;
}

#pragma mark -NSURLConnectionDataDelegate的委托方法

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //接收到服务器反馈消息(消息头)
    self.recvData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //接收到部分数据
    [self.recvData appendData:data];
    
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    static int i=1;
    
    NSLog(@"第%d次接收到数据!", i++);
    NSLog(@"\n\n\n%@\n\n\n", text);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //接收到所有数据
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *text = [[NSString alloc] initWithData:self.recvData encoding:NSUTF8StringEncoding];
    
    NSString * jsonStr = [NSString stringWithFormat:@"%@",text];
    
    NSLog(@"*******************\n\n%@\n\n**********************", jsonStr);
    
    [self setWeiboData:jsonStr];
    NSLog(@"数据刷新成功!");
    
    //重置接收到的消息
    self.recvData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //与服务器连接出错
    NSLog(@"与服务器连接出错  %@",error);
}

#pragma mark -set方法

- (void) setWeiboData:(NSString *) str{
    
    NSLog(@"+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH+-*LZH");
    
    NSDictionary * jsonDic = [LZHJsonEncoder dictionaryWithJsonString:str andSource:@"weiboDetailViewController-1"];
    
    NSString * response = [NSString stringWithFormat:@"%@", [jsonDic objectForKey:@"response"]];
    
    NSDictionary * responseDic = [LZHJsonEncoder dictionaryWithJsonString:response andSource:@"weiboDetailViewController-2"];
    
    NSString * commentListStr = [NSString stringWithFormat:@"%@", [responseDic objectForKey:@"commentList"]];
    
    NSDictionary * commentListDic = [LZHJsonEncoder dictionaryWithJsonString:commentListStr andSource:@"weiboDetailViewController-3"];
    
    NSMutableArray * commentArray = [[NSMutableArray alloc] init];
    
    NSInteger numberOfWeibo = [[NSString stringWithFormat:@"%@", [responseDic objectForKey:@"responseNumber"]] integerValue];
    
    if (numberOfWeibo == 0) {
        self.isCommentNumberEqualToZero = YES;
    }
    else{
        self.isCommentNumberEqualToZero = NO;
    }
    
    for(NSInteger i=0; i<numberOfWeibo; ++i){
        [commentArray addObject:[LZHJsonEncoder dictionaryWithJsonString:[commentListDic objectForKey:[NSString stringWithFormat:@"%ld", (long)i]]  andSource:@"weiboDetailViewController-4"] ];
    }
    //设置微博列表
    self.lzhCommentArray = commentArray;
    //刷新tableView
    [self.detailTableView reloadData];
}

- (void)setCommentNumber:(NSInteger)commentNumber{
    _commentNumber = commentNumber;
    [self.splitCommentButton setTitle:[NSString stringWithFormat:@"评论 %d", _commentNumber] forState:UIControlStateNormal];
}

- (void)setLikeNumber:(NSInteger)likeNumber{
    _likeNumber = likeNumber;
    [self.splitLikeButton setTitle:[NSString stringWithFormat:@"点赞 %d", _likeNumber] forState:UIControlStateNormal];
}


@end



















