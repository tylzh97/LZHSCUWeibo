//
//  LZHSliderViewController.h
//
//
//  Created by 李政浩 on 2018/5/12.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZHSliderBar.h"
#import "LZHMarco.h"

#import "ZFSettingViewController.h"
#import "LZHLoginViewController.h"

//声明被引用的类.@class 和 #import "class" 都可以引入一个类,但是为了避免重复引用,使用@class能够增加执行效率.
//引入滑块栏类
//@class LZHSliderBar;

//声明LZHSliderViewController所公开的接口
@interface LZHSliderViewController : UIViewController

/**
 *  为 LZHSliderViewController 的显式初始化方法
 *  childController : 需要添加的子视图控制器
 *  title : 视图控制器所对应的 title
 */
- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *) title;

/**
 *  导航栏上方的滑块拦
 */
@property (nonatomic, weak) LZHSliderBar* sliderBar;

/**
 *  设置上的 setting 图标.
 */
@property (nonatomic, strong) UIButton * settingButton;

/**
 *  ViewController 描述 Label
 */
@property (nonatomic, strong) UILabel * vcDiscribeLabel;

@property (strong, nonatomic) NSUserDefaults * defaults;

@end
