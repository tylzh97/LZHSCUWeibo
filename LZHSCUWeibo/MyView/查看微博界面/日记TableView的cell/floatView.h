//
//  floatView.h
//  ttteeestttt
//
//  Created by 李政浩 on 2018/5/11.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LZHMarco.h"


@interface floatView : UIView

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
 *初始化类方法.
 *(UIView *) view : 传入用于添加此界面的 view 
 */
+ (floatView *) showInView;

@end
