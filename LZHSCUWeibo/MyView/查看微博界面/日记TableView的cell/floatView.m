//
//  floatView.m
//  ttteeestttt
//
//  Created by 李政浩 on 2018/5/11.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "floatView.h"

@interface floatView()

@end

@implementation floatView

//唯一公开的类方法,用于将此 view 添加到 view 所在的屏幕上.
+(floatView *)showInView {
    //调用初始化方法.
    NSLog(@"黑人问号????");
    
    floatView *fview = [[floatView alloc] initShowInView];
    
    return fview;
}

//非公开的初始化方法,作用同上.
- (instancetype) initShowInView{
    //初始化 self 对象
    self = [super init];
    //若 self 创建成功
    if (self) {
        //将此 view 的范围设置为与母 view 一样大
        self.frame = [UIScreen mainScreen].bounds;
        //设置 self 的背景颜色为0.4透明度的黑色.
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        
        
        //将主视图的键盘回收.结束主视图的正在编辑状态.
        [[[UIApplication sharedApplication].windows objectAtIndex:0] endEditing:YES];
        //将 self 添加到主 view 所在的 window 中.
        //[[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
        ///////////////////////////////////////////////////[view addSubview:self];
        
        //使用此句话将可视视图添加到 self 上.
        [self initMainView];
        
        //使用渐变显示动画显示此 view
        [self showAlertAnimation];
        
        //创建一个手势,使当点击动作发生时,self 能够根据手势的不同从而做出不同的响应,响应 self 对象中的removeFromCurrentView:方法
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromCurrentView:)];
        //将手势添加到 self 对象上
        [self addGestureRecognizer:tapGesture];
    }
    //传回 self 对象
    return self;
}

- (void) initMainView {
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth-20, ScreenHeight-175)];
    _mainView.backgroundColor = [UIColor orangeColor];
    
    _mainView.tag = 99;
    _mainView.layer.cornerRadius = 20.0f;
    _mainView.layer.masksToBounds = YES;
    [self addSubview:_mainView];
    
    self.mainViewWidth  = _mainView.frame.size.width;
    self.mainViewHeight = _mainView.frame.size.height;
    
    [self addViewOnMainView];
    
}

- (void) addViewOnMainView{
    //上方蓝条
    UIView *headBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainViewWidth, 150)];
    headBarView.backgroundColor = [UIColor colorWithRed:(70)/255.0 green:(130)/255.0 blue:(180)/255.0 alpha:1.0];
    [self.mainView addSubview:headBarView];
    
    //下方蓝条
    UIView *footBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainViewHeight-60, self.mainViewWidth, 60)];
    footBarView.backgroundColor = [UIColor colorWithRed:(70)/255.0 green:(130)/255.0 blue:(180)/255.0 alpha:1.0];
    [self.mainView addSubview:footBarView];
    
    //上方蓝条的年月 label
    UILabel *yearAndMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    //yearAndMonthLabel.backgroundColor = [UIColor greenColor];
    [yearAndMonthLabel setCenter:CGPointMake(self.mainViewWidth/2, 15)];
    yearAndMonthLabel.textAlignment = NSTextAlignmentCenter;
    yearAndMonthLabel.text = @"2018年 5月";
    yearAndMonthLabel.textColor = [UIColor whiteColor];
    [headBarView addSubview:yearAndMonthLabel];
    
    //上方蓝条中的日期 label(大)
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    //dateLabel.backgroundColor = [UIColor greenColor];
    [dateLabel setCenter:CGPointMake(headBarView.frame.size.width/2, headBarView.frame.size.height/2)];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = @"12";
    dateLabel.font = [UIFont systemFontOfSize:50];
    dateLabel.textColor = [UIColor whiteColor];
    [headBarView addSubview:dateLabel];
    
    //上方蓝条中的星期以及时间 label
    UILabel *weekAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    //weekAndTimeLabel.backgroundColor = [UIColor greenColor];
    [weekAndTimeLabel setCenter:CGPointMake(headBarView.frame.size.width/2, headBarView.frame.size.height-15)];
    weekAndTimeLabel.textAlignment = NSTextAlignmentCenter;
    weekAndTimeLabel.text = @"星期六 01:00";
    weekAndTimeLabel.textColor = [UIColor whiteColor];
    [headBarView addSubview:weekAndTimeLabel];
    
    //日记文本 textview
    UITextView *diaryTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, headBarView.frame.size.height, self.mainViewWidth, footBarView.frame.origin.y-headBarView.frame.size.height)];
    diaryTextView.text = @"2018年5月12日,群主不女装,这个仇我先记下了!";
    diaryTextView.backgroundColor = [UIColor whiteColor];
    diaryTextView.font = [UIFont fontWithName:@"LingWai SC" size:18];
    diaryTextView.textColor = [UIColor colorWithRed:(70)/255.0 green:(130)/255.0 blue:(180)/255.0 alpha:1.0];
    //diaryTextFiled.font = [UIFont systemFontOfSize:15];
    diaryTextView.editable = NO;
    [self.mainView addSubview:diaryTextView];
    
    //下方分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareButton.frame = CGRectMake(0, 0, 30, 30);
    [shareButton setCenter:CGPointMake(35, footBarView.frame.size.height/2)];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [footBarView addSubview:shareButton];
    
    //下方删除按钮
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteButton.frame = CGRectMake(0, 0, 30, 30);
    [deleteButton setCenter:CGPointMake(footBarView.frame.size.width-35, footBarView.frame.size.height/2)];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [footBarView addSubview:deleteButton];
}

//alapahWindow 的 get 方法
- (UIWindow *)alphaWindow {
    if (!_alphaWindow) {
        _alphaWindow = [[UIWindow alloc] init];
        _alphaWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _alphaWindow.windowLevel = 100;
    }
    return _alphaWindow;
}

//此函数,使用动画将 self 对象添加到 view 对象上.
- (void)showAlertAnimation
{
    self.alphaWindow.frame = [UIScreen mainScreen].bounds;
    [self.alphaWindow makeKeyAndVisible];
    [self.alphaWindow addSubview:self];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue         = [NSNumber numberWithFloat:0];
    animation.toValue           = [NSNumber numberWithFloat:1];
    animation.duration          = 0.25;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animation forKey:@"opacity"];
}

//点按动作触发的函数.当检测到点按时,执行此函数
-(void)removeFromCurrentView:(UIGestureRecognizer *)gesture
{
    UIView * subView    = (UIView *)[self viewWithTag:99];
    UIView * shadowView = self;
    //若手势发生位置位于 shadowview 内
    if (CGRectContainsPoint(subView.frame, [gesture locationInView:shadowView])){
        NSLog(@"落进主视图里面了,咱不响应!");
        
    }
    else{
        NSLog(@"点外面嘞,咱回去休息一下~");
        [self removeSelfFromSuperview];
    }
}

//将此时图从 view 中国移除的方法.渐变动画消失
- (void)removeSelfFromSuperview
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alphaWindow.hidden = YES;
    }];
}

@end
