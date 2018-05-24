//
//  DiaryView.m
//  MyDiary
//
//  Created by 李政浩 on 2018/5/7.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "DiaryView.h"

@interface DiaryView ()

@property (strong, nonatomic) IBOutlet UITextField *diaryName;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *moodLabel;
@property (strong, nonatomic) IBOutlet UIStepper *steperLabel;
@property (strong, nonatomic) IBOutlet UITextView *diaryView;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UILabel *diaryNameLabel;

@end

@implementation DiaryView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置 self 的 view 属性大小为屏幕大小
    self.view.frame = [UIScreen mainScreen].bounds;
    //设置 self.view 不显示超出部分.
    self.view.layer.masksToBounds = YES;
    
    //设置导航栏 title
    self.navigationItem.title = self.tabBarItem.title;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.appDelegate.LZHTCPDelegate = self;
    
    
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    //NSDate转NSString
    NSString *currentDateString = [[dateFormatter stringFromDate:currentDate] substringToIndex:19];
    [_dateLabel setText:currentDateString];
    
    
    [self initlizeKits];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//将主屏幕控件放置在合理的布局上.此方法用于计算布局,能够让控件根据不同的屏幕自动适应位置.
- (void) initlizeKits{
    self.diaryNameLabel.frame = CGRectMake(10, self.appDelegate.UINavigationBarHeight+10, 100, 30);
    
    self.diaryName.frame = CGRectMake(130, self.appDelegate.UINavigationBarHeight+10, self.appDelegate.screenSize.width-140, 30);
    
    self.dateLabel.frame = CGRectMake(10, self.appDelegate.UINavigationBarHeight+50, 180, 30);
    
    self.steperLabel.frame = CGRectMake(self.appDelegate.screenSize.width-self.steperLabel.frame.size.width-10, self.appDelegate.UINavigationBarHeight+50, self.steperLabel.frame.size.width, self.steperLabel.frame.size.height);
    
    self.moodLabel.frame = CGRectMake(self.appDelegate.screenSize.width-self.steperLabel.frame.size.width-40, self.appDelegate.UINavigationBarHeight+50, 30, 30);
    
    self.uploadButton.frame = CGRectMake(10, self.appDelegate.screenSize.height-self.appDelegate.UITabbarHeight-60, self.appDelegate.screenSize.width-20, 50);
    
    self.diaryView.frame = CGRectMake(10, self.dateLabel.frame.origin.y+50, self.appDelegate.screenSize.width-20,  self.appDelegate.screenSize.height-self.appDelegate.UITabbarHeight-70-(self.dateLabel.frame.origin.y+50));
    
}

- (IBAction)setMood:(id)sender {
    NSArray * moodArray = @[@"🙃", @"🙁", @"😑", @"🙂", @"😃" ];
    
    //[_steperLabel setValue:0];
    [_moodLabel setText:moodArray[(int)[_steperLabel value]]];

}

- (IBAction)uploadAction:(id)sender {
    NSString * diaryData = _diaryView.text;
    [self.appDelegate sendSocketMessage:diaryData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)connectionSuccessful {
    NSLog(@"CONNECTION---FROM Diary View");
}

- (void)messageReceived:(NSString *)receivedMessage {
    NSLog(@"%@---FROM Diary View",receivedMessage);
}

- (void)socketPipeBreak {
    NSLog(@"Connection Break!---FROM Diary View");
}

@end
