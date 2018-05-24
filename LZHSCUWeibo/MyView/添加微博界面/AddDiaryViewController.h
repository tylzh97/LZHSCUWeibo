//
//  AddDiaryViewController.h
//  MyDiarySliderVersion
//
//  Created by 李政浩 on 2018/5/14.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LZHJsonEncoder.h"

@interface AddDiaryViewController : UIViewController

/**
 *为了方便管理,请将所有希望显示的界面显示在 mainView 上
 */
@property (strong, nonatomic) UIView *mainView;
/**
 *为 mainView 的宽度
 */
@property (assign, nonatomic) CGFloat mainViewWidth;
/**
 *为 mainView 的高度
 */
@property (assign, nonatomic) CGFloat mainViewHeight;
/**
 *为覆盖在原 window 上的新 window
 */
@property (strong, nonatomic) UIWindow *alphaWindow;

/**
 *为撰写视图上,星期与时间的 label
 */
@property (strong, nonatomic) UILabel *weekAndTimeLabel;

/**心情索引*/
@property (assign, nonatomic) NSInteger moodIndex;

/**天气索引*/
@property (assign, nonatomic) NSInteger weatherIndex;

/**天气按钮*/
@property (strong, nonatomic) UIButton * weatherButton;

/**心情按钮*/
@property (strong, nonatomic) UIButton * moodButton;

/**保存按钮*/
@property (strong, nonatomic) UIButton * saveButton;

/**日记标题TextField*/
@property (strong, nonatomic) UITextField *diaryTitleTextField;

/**日记内容 TextField */
@property (strong, nonatomic) UITextView *diaryTextView;


/**
 *  appDelegate 对象
 */
@property (strong, nonatomic) AppDelegate *appDelegate;

@end
