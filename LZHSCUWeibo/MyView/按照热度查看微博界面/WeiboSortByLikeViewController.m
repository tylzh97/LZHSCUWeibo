//
//  WeiboSortByLikeViewController.m
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/6.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "WeiboSortByLikeViewController.h"

#define LZHScreenSize [UIScreen mainScreen].bounds.size
#define MJRandomData [NSString stringWithFormat:@"%d", arc4random_uniform(1000000)]

@interface WeiboSortByLikeViewController ()

@property (strong, nonatomic) NSMutableArray *arrayModel;
@property (strong, nonatomic) NSMutableArray *arrayModelDay;

//接收到的网络数据
@property (strong, nonatomic) NSMutableData * recvData;
@property (strong, nonatomic) NSMutableArray * weiboArray;

@end

@implementation WeiboSortByLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置 self 的 view 属性大小为屏幕大小
    self.view.frame = [UIScreen mainScreen].bounds;
    //设置 self.view 不显示超出部分.
    self.view.layer.masksToBounds = YES;
    
    //设置导航栏 title
    self.navigationItem.title = self.tabBarItem.title;
    
    //初始化数据源
    _arrayModel = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    //获取 appDelegate 对象,以获取其中需要的属性.
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //初始化 tableView
    [self initTableView];
    
    [self.mainTableView setBackgroundView:nil];
    [self.mainTableView setBackgroundView:[[UIView alloc] init]];
    self.mainTableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.mainTableView.backgroundColor = [UIColor clearColor];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.weiboArray = [defaults objectForKey:@"weiboLikeList"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化TableVIew
- (void) initTableView{
    //self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.appDelegate.screenSize.width, self.appDelegate.screenSize.height) style:UITableViewStyleGrouped];
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.appDelegate.screenSize.width, self.appDelegate.screenSize.height) style:UITableViewStylePlain];
    
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    //self.mainTableView.mj_h = self.appDelegate.screenSize.height;
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    
    
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

- (NSMutableArray *)data
{
    
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:MJRandomData];
        }
    }
    return _data;
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

- (void)loadNewData
{
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    self.recvData = [[NSMutableData alloc] init];
    
    NSString *currTime = [self getCurrTimeString];
    
    //NSString * strUrl = @"http://127.0.0.1:8000/checkByTime?userID=用户id&time=时间&check=验证码&requestNumber=请求微博数";
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * httpAddress = [defaults objectForKey:@"HTTPAddress"];
    
    NSString * strUrl = [NSString stringWithFormat:@"%@/checkByAgreement?userID=%@&time=%@&check=%@&requestNumber=%d", httpAddress, @"userName" , currTime, [self getCheckCodeWithRequest:@"checkByAgreement" andTime:currTime], 20 ];
    //strUrl = [strUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
    [NSURLConnection connectionWithRequest:request delegate:self];
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //TODO:应当使用同步请求,我使用了异步请求,将会在以后的版本中进行改进.!!!!!TODO
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.mainTableView;
    CGFloat refreashDuration = 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(refreashDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.mainTableView;
    CGFloat refreashDuration = 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(refreashDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}
#pragma mark -NSURLConnectionDataDelegate的委托方法

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //接收到服务器反馈消息(消息头)
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //接收到部分数据
    [self.recvData appendData:data];
    
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
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
    self.recvData = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //与服务器连接出错
    NSLog(@"与服务器连接出错  %@",error);
}


- (void) setWeiboData:(NSString *) str{
    NSDictionary * jsonDic = [LZHJsonEncoder dictionaryWithJsonString:str andSource:@"weiboSortByLikeViewController -1"];
    NSString * response = [NSString stringWithFormat:@"%@", [jsonDic objectForKey:@"response"]];
    NSDictionary * responseDic = [LZHJsonEncoder dictionaryWithJsonString:response andSource:@"weiboSortByLikeViewController -2"];
    NSString * weiboListStr = [NSString stringWithFormat:@"%@", [responseDic objectForKey:@"weiboList"]];
    NSDictionary * weiboListDic = [LZHJsonEncoder dictionaryWithJsonString:weiboListStr andSource:@"weiboSortByLikeViewController -3"];
    NSMutableArray * weiboArray = [[NSMutableArray alloc] init];
    NSInteger numberOfWeibo = [[NSString stringWithFormat:@"%@", [responseDic objectForKey:@"responseNumber"]] integerValue];
    
    for(NSInteger i=0; i<numberOfWeibo; ++i){
        [weiboArray addObject:[LZHJsonEncoder dictionaryWithJsonString:[weiboListDic objectForKey:[NSString stringWithFormat:@"%ld", (long)i]]  andSource:@"weiboSortByLikeViewController -4"] ];
        //NSLog(@"\n%ld  %@   %@\n\n", (long)i, [weiboArray[i] objectForKey:@"userName"], [weiboArray[i] objectForKey:@"weiboDetail"]);
    }
    //设置微博列表
    self.weiboArray = weiboArray;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.weiboArray forKey:@"weiboLikeList"];
    [defaults synchronize];
}

#pragma mark -UITableViewDataSource Methods
// 创建 tableView 的第indexPath 所对应的 cell 的函数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //尝试从 cell 池中获取编号为 weiboCell 的 cell
    LZHWeiboCell * cell = [tableView dequeueReusableCellWithIdentifier:@"weiboCell"];
    //若没有取到
    if(!cell){
        //创建一个新的 cell, 并将此 cell 放入 cell 池中
        cell = [[LZHWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weiboCell"];
    }
    //获取当前微博字典
    NSMutableDictionary * currWeibo = [self.weiboArray objectAtIndex:indexPath.row];
    //{userID=[用户 id],username=[用户名],weiboTime=[微博发送时间],weiboDetail=[微博详情],commentNumber=[评论数],agreeNumber=[点赞数], weiboID=[微博 ID]},
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
    NSDate *weiboDate = [formatter1 dateFromString:[currWeibo objectForKey:@"weiboTime"]];
    
    [cell setUserNickname:[currWeibo objectForKey:@"userName"] ];
    [cell setPublishedTime:weiboDate];
    [cell setPublishedSource:@"来自 weibo.com"];
    [cell setWeiboDetail:[currWeibo objectForKey:@"weiboDetail"]];
    [cell setCommentsNumber:[[currWeibo objectForKey:@"commentNumber"] intValue]];
    [cell setThumbsupNumber:[[currWeibo objectForKey:@"agreeNumber"] intValue]];
    
    return cell;
}

//该函数为UITabBarDelegate委托中的函数,点按 cell 后,将会触发此函数
- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected");
    //取消选择当前 cell
    [tv deselectRowAtIndexPath:indexPath animated:YES];
}

//位于 UITableViewDelegate 委托中的方法,用于设置每一个 cell 的高度
//每个分组下对应的tableView高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZHWeiboCell * cell = (LZHWeiboCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight+16.5;
}

//用于设置 table 的 section 个数.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//该函数为UITableViewDataSource 委托中的必要委托函数,用于返回每个 section 个数.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.weiboArray.count;
}


@end
