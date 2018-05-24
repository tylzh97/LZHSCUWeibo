//
//  AddDiaryViewController.m
//  MyDiarySliderVersion
//
//  Created by 李政浩 on 2018/5/14.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "AddDiaryViewController.h"

#define WEATHER_AT_INDEX(index) @[@"sunny_highlight",@"rain_highlight",@"cloudy_highlight",@"snow_highlight"][(index)]
#define MOOD_AT_INDEX(index)    @[@"happy_highlight",@"normal_highlight",@"sad_highlight"][(index)]

@interface AddDiaryViewController ()

@end

@implementation AddDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //将自身框架设置为与屏幕大小相同
    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self initMainView];
    
}

- (void) initMainView {
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.appDelegate.UINavigationBarHeight, ScreenWidth, ScreenHeight-self.appDelegate.UINavigationBarHeight)];
    _mainView.backgroundColor = [UIColor grayColor];
    
    //_mainView.tag = 99;
    //_mainView.layer.cornerRadius = 20.0f;
    _mainView.layer.masksToBounds = YES;
    [self.view addSubview:_mainView];
    
    self.mainViewWidth  = _mainView.frame.size.width;
    self.mainViewHeight = _mainView.frame.size.height;
    
    [self addViewOnMainView];
    
}

- (void) addViewOnMainView{
    NSArray *weekdays = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    //NSLog(@"字符串表示1:%@",dateStr);
    //获取年与月
    NSString * strYearAndMonth = [NSString stringWithFormat:@"%@年 %@月",[dateStr substringToIndex:4], [dateStr substringWithRange:NSMakeRange(5, 2)]];
    //获取日期
    NSString * strDate = [dateStr substringWithRange:NSMakeRange(8, 2)];

    //获取星期
    NSDateComponents *theComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:NSCalendarUnitWeekday fromDate:date];
    NSString * strWeek = weekdays[theComponents.weekday-1];
   
    
    //获取时间
    NSString * strTime = [dateStr substringFromIndex:11];
    
    //NSLog(@"%@,%@,%@,%@",strYearAndMonth,strDate, strWeek,strTime);
    
    //上方蓝条
    UIView *headBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainViewWidth, 150)];
    headBarView.backgroundColor = [UIColor colorWithRed:(70)/255.0 green:(130)/255.0 blue:(180)/255.0 alpha:1.0];
    [self.mainView addSubview:headBarView];
    
    //下方蓝条
    UIView *footBarView;
    if(self.appDelegate.isIphoneX){
        footBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainViewHeight-60-20, self.mainViewWidth, 60+20)];
    }
    else{
        footBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainViewHeight-60, self.mainViewWidth, 60)];
    }
    //UIView *footBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainViewHeight-60, self.mainViewWidth, 60)];
    footBarView.backgroundColor = [UIColor colorWithRed:(70)/255.0 green:(130)/255.0 blue:(180)/255.0 alpha:1.0];
    [self.mainView addSubview:footBarView];
    
    //上方蓝条的年月 label
    UILabel *yearAndMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    //yearAndMonthLabel.backgroundColor = [UIColor greenColor];
    [yearAndMonthLabel setCenter:CGPointMake(self.mainViewWidth/2, 15)];
    yearAndMonthLabel.textAlignment = NSTextAlignmentCenter;
    yearAndMonthLabel.text = strYearAndMonth;
    yearAndMonthLabel.textColor = [UIColor whiteColor];
    [headBarView addSubview:yearAndMonthLabel];
    
    //上方蓝条中的日期 label(大)
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    //dateLabel.backgroundColor = [UIColor greenColor];
    [dateLabel setCenter:CGPointMake(headBarView.frame.size.width/2, headBarView.frame.size.height/2)];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = strDate;
    dateLabel.font = [UIFont systemFontOfSize:50];
    dateLabel.textColor = [UIColor whiteColor];
    [headBarView addSubview:dateLabel];
    
    //上方蓝条中的星期以及时间 label
    UILabel *weekAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    //weekAndTimeLabel.backgroundColor = [UIColor greenColor];
    [weekAndTimeLabel setCenter:CGPointMake(headBarView.frame.size.width/2, headBarView.frame.size.height-15)];
    weekAndTimeLabel.textAlignment = NSTextAlignmentCenter;
    weekAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", strWeek, strTime];
    weekAndTimeLabel.textColor = [UIColor whiteColor];
    [headBarView addSubview:weekAndTimeLabel];
    self.weekAndTimeLabel = weekAndTimeLabel;
    //添加计时器,更新时间
    //NSTimer Mark-1
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshDateLabel) userInfo:nil repeats:YES];
    
    //日记标题 TestField
    UITextField *diaryTestField = [[UITextField alloc] initWithFrame:CGRectMake(0, headBarView.frame.size.height-1, ScreenWidth, 45)];
    diaryTestField.backgroundColor = [UIColor whiteColor];
    diaryTestField.placeholder = @"标题";
    diaryTestField.font = [UIFont fontWithName:@"LingWai SC" size:25];
    [self.mainView addSubview:diaryTestField];
    self.diaryTitleTextField = diaryTestField;
    
    
    //日记文本 textview
    UITextView *diaryTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, headBarView.frame.size.height+diaryTestField.frame.size.height, self.mainViewWidth, footBarView.frame.origin.y-headBarView.frame.size.height-diaryTestField.frame.size.height)];
    diaryTextView.text = @"";
    diaryTextView.backgroundColor = [UIColor whiteColor];
    diaryTextView.font = [UIFont fontWithName:@"LingWai SC" size:18];
    diaryTextView.textColor = [UIColor colorWithRed:(70)/255.0 green:(130)/255.0 blue:(180)/255.0 alpha:1.0];
    //diaryTextFiled.font = [UIFont systemFontOfSize:15];
    diaryTextView.editable = YES;
    [self.mainView addSubview:diaryTextView];
    self.diaryTextView = diaryTextView;
    
    //下方心情选择按钮
    UIButton *moodButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    moodButton.frame = CGRectMake(0, 0, 30, 30);
    [moodButton setCenter:CGPointMake(35, 20)];
    [moodButton setBackgroundImage:[UIImage imageNamed:@"happy_highlight"] forState:UIControlStateNormal];
    self.moodIndex = 0;
    [footBarView addSubview:moodButton];
    [moodButton addTarget:self action:@selector(moodTouched) forControlEvents:UIControlEventTouchUpInside];
    self.moodButton = moodButton;
    
    //下方天气选择按钮
    UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    weatherButton.frame = CGRectMake(0, 0, 30, 30);
    [weatherButton setCenter:CGPointMake(80, 20)];
    [weatherButton setBackgroundImage:[UIImage imageNamed:@"sunny_highlight"] forState:UIControlStateNormal];
    self.weatherIndex = 0;
    [footBarView addSubview:weatherButton];
    [weatherButton addTarget:self action:@selector(weatherTouched) forControlEvents:UIControlEventTouchUpInside];
    self.weatherButton = weatherButton;
    
    //下方保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(0, 0, 30, 30);
    [saveButton setCenter:CGPointMake(footBarView.frame.size.width-35, 20)];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [footBarView addSubview:saveButton];
    [saveButton addTarget:self action:@selector(saveTouched) forControlEvents:UIControlEventTouchUpInside];
    self.saveButton = saveButton;
}

//"保存"按钮按下时,执行此方法
- (void) saveTouched{
    NSLog(@"保存");
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString = [dateFormatter stringFromDate:date];
    
    NSString *diaryTitle = self.diaryTitleTextField.text;
    NSString *diaryContent = self.diaryTextView.text;
    NSString *mood = MOOD_AT_INDEX(self.moodIndex);
    NSString *weather = WEATHER_AT_INDEX(self.weatherIndex);
    
    NSDictionary *diaryDic = [[NSDictionary alloc] initWithObjectsAndKeys:timeString, @"time", diaryTitle, @"title", diaryContent, @"content", mood, @"mood", weather, @"weather", nil];
    
    NSLog(@"%@",diaryDic);
    
    NSString * jsontest = [LZHJsonEncoder dictionaryToJson:diaryDic];
    NSLog(@"*******json********\n%@", jsontest);
    
    NSDictionary * jsonDic = [LZHJsonEncoder dictionaryWithJsonString:jsontest];
    NSLog(@"*******DIC********\n%@", jsonDic);
    
    NSString *recvTimeString = [jsonDic objectForKey:@"time"];
    
    NSString *recvDiaryTitle = [jsonDic objectForKey:@"title"];
    NSString *recvDiaryContent = [jsonDic objectForKey:@"content"];
    NSString *recvMood = [jsonDic objectForKey:@"mood"];
    NSString *recvWeather = [jsonDic objectForKey:@"weather"];
    
    NSLog(@"time : %@\ntitle : %@\ncontent : %@\nmood : %@\nweather : %@",recvTimeString, recvDiaryTitle, recvDiaryContent, recvMood, recvWeather);
    
}

//"天气"按钮按下时,执行此方法
- (void) weatherTouched{
    //NSLog(@"切换天气");
    if((int)self.weatherIndex <3){
        self.weatherIndex ++;
    }
    else{
        self.weatherIndex = 0;
    }

    [self.weatherButton setBackgroundImage:[UIImage imageNamed:WEATHER_AT_INDEX(self.weatherIndex)] forState:UIControlStateNormal];
}

//"心情"按钮按下时,执行此方法
- (void) moodTouched{
    //NSLog(@"切换心情");
    if((int)self.moodIndex <2){
        self.moodIndex ++;
    }
    else{
        self.moodIndex = 0;
    }
    
    [self.moodButton setBackgroundImage:[UIImage imageNamed:MOOD_AT_INDEX(self.moodIndex)] forState:UIControlStateNormal];
}

//被位于 NSTimer Mark-1 处的 NSTimer 调用,用于更新时间.
- (void) refreshDateLabel {
    UILabel * label = self.weekAndTimeLabel;
    
    NSArray *weekdays = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    //获取星期
    NSDateComponents *theComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:NSCalendarUnitWeekday fromDate:date];
    NSString * strWeek = weekdays[theComponents.weekday-1];
    //获取时间
    NSString * strTime = [dateStr substringFromIndex:11];
    
    label.text = [NSString stringWithFormat:@"%@ %@", strWeek, strTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
