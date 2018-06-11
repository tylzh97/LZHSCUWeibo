//
//  LZHAddWeiboViewController.m
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/5.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHAddWeiboViewController.h"
#import "lzhHash.h"

@interface LZHAddWeiboViewController ()

//网络请求接收到的消息
@property (strong, nonatomic) NSMutableData * recvData;

@end

@implementation LZHAddWeiboViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化发送微博界面
- (void) loadUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadNavigationBar];
    [self loadNewWeiboView];
}

//初始化UINavigationBar
- (void) loadNavigationBar{
    
    //tabbar中央视图
    UIView * barCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    UILabel * sendWeiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    UILabel * userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 15)];
    
    sendWeiboLabel.text = @"发微博";
    sendWeiboLabel.font = [UIFont systemFontOfSize:20];
    [sendWeiboLabel setCenter:CGPointMake(barCenterView.bounds.size.width/2, sendWeiboLabel.bounds.size.height/2)];
    //sendWeiboLabel.backgroundColor = [UIColor blueColor];
    sendWeiboLabel.textAlignment = NSTextAlignmentCenter;
    sendWeiboLabel.textColor = [UIColor blackColor];
    [barCenterView addSubview:sendWeiboLabel];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    userNameLabel.text = [NSString stringWithFormat:@"@%@", [defaults objectForKey:@"userName"]];
    userNameLabel.font = [UIFont systemFontOfSize:10];
    [userNameLabel setCenter:CGPointMake(barCenterView.bounds.size.width/2, barCenterView.bounds.size.height-userNameLabel.bounds.size.height/2)];
    //userNameLabel.backgroundColor = [UIColor greenColor];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.textColor = [UIColor grayColor];
    [barCenterView addSubview:userNameLabel];
    
    //barCenterView.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = barCenterView;
    
    //tabbar左侧按钮
    UIBarButtonItem * cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPushed)];
    cancelBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
    
    //tabbar右侧按钮
    UIButton * sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton.frame = CGRectMake(0, 0, 40, 30);
    sendButton.backgroundColor = [UIColor orangeColor];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * sendBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendBarButtonItem;
}

- (void) loadNewWeiboView{
    self.weiboField = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.weiboField setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:self.weiboField];
    [self.weiboField setScrollEnabled:NO];
    
    _recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [_recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.weiboField addGestureRecognizer:_recognizer];
    
    /*
    self.weiboField = [[LZHWeiboTextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.weiboField setFont:[UIFont systemFontOfSize:20]];
    
    [self.view addSubview:self.weiboField];
     */
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"swipe down");
        [self.weiboField endEditing:YES];
        //[self resignFirstResponder];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
    }
}

- (void) cancelPushed{
    //此方法官方推荐设计为代理,在需要返回的界面中触发.
    //此处为了简化工作,故直接在此处调用.
    //TODO
    [self dismissViewControllerAnimated:YES completion:nil];
}


//获取当前标准时间
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
//获取验证码
- (NSString *) getCheckCodeWithRequest:(NSString *)request andTime:(NSString *)timeStr{
    NSString *checkCode = [lzhHash md5:[NSString stringWithFormat:@"%@%@", request, timeStr]];
    checkCode = [lzhHash md5:[checkCode substringFromIndex:[checkCode length]-5]];
    return [checkCode uppercaseString];
}

//执行发送微博功能
/*
 3.发布新微博
 请求头:publishNewWeibo?userID=[用户id]&time=[时间]&check=[验证码]&detail=[微博详情]
 反馈:
 {
 request='publishNewWeibo',
 time=[时间],
 check=[验证码],
 response=
 {
 isSuccess=[TRUE/FALSE],
 weiboID=[微博ID]
 }
 }
 */
- (void) sendPushed{
    NSLog(@"发送");
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    self.recvData = [[NSMutableData alloc] init];
    
    NSString *currTime = [self getCurrTimeString];
    
    //NSString * strUrl = @"http://127.0.0.1:8000/checkByTime?userID=用户id&time=时间&check=验证码&requestNumber=请求微博数";
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * httpAddress = [defaults objectForKey:@"HTTPAddress"];
    
    //NSString * localUserName = [defaults objectForKey:@"userName"];
    NSString * localUserID = [defaults objectForKey:@"userID"];
    
    NSString * strUrl = [NSString stringWithFormat:@"%@/publishNewWeibo?userID=%@&time=%@&check=%@&detail=%@", httpAddress, localUserID, currTime, [self getCheckCodeWithRequest:@"publishNewWeibo" andTime:currTime], self.weiboField.text];
    //strUrl = [strUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL];
    [NSURLConnection connectionWithRequest:request delegate:self];
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
}


#pragma mark -NSURLConnectionDataDelegate的委托方法

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //接收到服务器反馈消息(消息头)
    
    NSLog(@"发送微博服务器反馈啦!");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //接收到部分数据
    [self.recvData appendData:data];
    
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"客户端接收到部分服务器消息:\n\n\n%@\n\n\n", text);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //接收到所有数据
    //NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *text = [[NSString alloc] initWithData:self.recvData encoding:NSUTF8StringEncoding];
    
    NSString * jsonStr = [NSString stringWithFormat:@"%@",text];
    
    NSLog(@"客户端接收到所有服务器消息:*******************\n\n%@\n\n**********************", jsonStr);
    
    
    NSLog(@"所有消息接收完毕");
    
    //重置接收到的消息
    self.recvData = nil;
    self.weiboField.text = @"";
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //与服务器连接出错
    NSLog(@"与服务器连接出错  %@",error);
}

@end
