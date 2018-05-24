//
//  LZHLoginViewController.h
//  MyDiarySliderVersion
//
//  Created by 李政浩 on 2018/5/15.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZHMarco.h"

@interface LZHLoginViewController : UIViewController

/**登陆按钮*/
@property (strong, nonatomic) UIButton * gotoLoginButton;

/**注册按钮*/
@property (strong, nonatomic) UIButton * gotoEnrollButton;

/**LoginView*/
@property (strong, nonatomic) UIView * loginView;

/**enrollView*/
@property (strong, nonatomic) UIView * enrollView;

@end
