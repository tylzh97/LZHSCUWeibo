//
//  LZHLoginViewController.m
//  MyDiarySliderVersion
//
//  Created by 李政浩 on 2018/5/15.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHLoginViewController.h"

@interface LZHLoginViewController ()

@end

@implementation LZHLoginViewController

- (UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
    
}



- (BOOL)prefersStatusBarHidden

{
    return YES; //返回NO表示要显示，返回YES将hiden
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backgroundView.image = [UIImage imageNamed:@"loginBackground"];
    [self.view addSubview:backgroundView];
    
    [self initUI];
    
}

- (void) initUI{
    //登陆按钮
    UIButton * gotoLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gotoLoginButton.frame = CGRectMake(0, 0, ScreenWidth*0.45, ScreenWidth*0.4*0.33);
    [gotoLoginButton setCenter:CGPointMake(ScreenWidth*0.25, ScreenHeight*0.65)];
    [gotoLoginButton setTitle:@"登陆" forState:UIControlStateNormal];
    gotoLoginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [gotoLoginButton setTintColor:[UIColor whiteColor]];
    [gotoLoginButton.layer setCornerRadius:ScreenWidth*0.4*0.33*0.5];
    gotoLoginButton.layer.borderWidth = 3;
    gotoLoginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:gotoLoginButton];
    [gotoLoginButton addTarget:self action:@selector(loginAnimation) forControlEvents:UIControlEventTouchUpInside];
    self.gotoLoginButton = gotoLoginButton;
    
    //注册按钮
    UIButton * gotoEnrollButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gotoEnrollButton.frame = CGRectMake(0, 0, ScreenWidth*0.45, ScreenWidth*0.4*0.33);
    [gotoEnrollButton setCenter:CGPointMake(ScreenWidth*0.75, ScreenHeight*0.65)];
    [gotoEnrollButton setTitle:@"注册" forState:UIControlStateNormal];
    gotoEnrollButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [gotoEnrollButton setTintColor:[UIColor whiteColor]];
    [gotoEnrollButton.layer setCornerRadius:ScreenWidth*0.4*0.33*0.5];
    gotoEnrollButton.layer.borderWidth = 3;
    gotoEnrollButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:gotoEnrollButton];
    [gotoEnrollButton addTarget:self action:@selector(enrollAnimation) forControlEvents:UIControlEventTouchUpInside];
    self.gotoEnrollButton = gotoEnrollButton;
    
    //添加登陆界面
    self.loginView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.loginView setCenter:CGPointMake(ScreenWidth*1.5, ScreenHeight*0.5)];
    [self.view addSubview:self.loginView];
    //添加登陆界面的用户名条
    UITextField * userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.7, 40)];
    [userNameTF setCenter:CGPointMake(ScreenWidth/2, ScreenHeight*0.6)];
    userNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 35)];
    userNameTF.leftViewMode = UITextFieldViewModeAlways;
    [userNameTF setTextColor:[UIColor whiteColor]];
    [userNameTF setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    //userNameTF.layer.borderWidth = 1;
    //[userNameTF.layer setCornerRadius:userNameTF.frame.size.height/2];
    //userNameTF.layer.borderColor = [UIColor whiteColor].CGColor;
    userNameTF.font = [UIFont systemFontOfSize:12];
    userNameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名或账号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]}];
    [self.loginView addSubview:userNameTF];
    //添加登陆界面的密码条
    UITextField * passwdTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.7, 40)];
    //放置在用户名下方10个像素位置
    [passwdTF setCenter:CGPointMake(ScreenWidth/2, CGRectGetMaxY(userNameTF.frame)+30)];
    passwdTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    //设置为密码模式
    passwdTF.secureTextEntry = YES;
    passwdTF.leftViewMode = UITextFieldViewModeAlways;
    [passwdTF setTextColor:[UIColor whiteColor]];
    [passwdTF setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    //passwdTF.layer.borderWidth = 1;
    //[passwdTF.layer setCornerRadius:userNameTF.frame.size.height/2];
    //passwdTF.layer.borderColor = [UIColor whiteColor].CGColor;
    passwdTF.font = [UIFont systemFontOfSize:12];
    passwdTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]}];
    [self.loginView addSubview:passwdTF];
    //登陆按钮
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(0, 0, ScreenWidth*0.5, 40);
    [loginButton setCenter:CGPointMake(ScreenWidth/2, CGRectGetMaxY(passwdTF.frame)+30)];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor colorWithRed:30/255.0 green:158/255.0 blue:236/255.0 alpha:1]];
    [loginButton.layer setCornerRadius:loginButton.frame.size.height/2];
    [self.loginView addSubview:loginButton];
    //没有账号?
    UIButton * iHaveNoAccountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    iHaveNoAccountButton.frame = CGRectMake(0, 0, ScreenWidth*0.4, 20);
    [iHaveNoAccountButton setCenter:CGPointMake(ScreenWidth*0.35, CGRectGetMaxY(loginButton.frame)+15)];
    [iHaveNoAccountButton setTitle:@"没有账号?" forState:UIControlStateNormal];
    [iHaveNoAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    iHaveNoAccountButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.loginView addSubview:iHaveNoAccountButton];
    //忘记密码?
    UIButton * iForgetedPasswdButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    iForgetedPasswdButton.frame = CGRectMake(0, 0, ScreenWidth*0.4, 20);
    [iForgetedPasswdButton setCenter:CGPointMake(ScreenWidth*0.65, CGRectGetMaxY(loginButton.frame)+15)];
    [iForgetedPasswdButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [iForgetedPasswdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    iForgetedPasswdButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.loginView addSubview:iForgetedPasswdButton];
    
}

- (void) loginDisappear{
    [UIView animateWithDuration:0.1 animations:^{
        [self.gotoLoginButton setCenter:CGPointMake([self.gotoLoginButton center].x+30, [self.gotoLoginButton center].y)];
        [self.gotoEnrollButton setCenter:CGPointMake([self.gotoEnrollButton center].x+30, [self.gotoEnrollButton center].y)];
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.gotoLoginButton setCenter:CGPointMake([self.gotoLoginButton center].x-ScreenWidth-30, [self.gotoLoginButton center].y)];
        [self.gotoEnrollButton setCenter:CGPointMake([self.gotoEnrollButton center].x-ScreenWidth-30, [self.gotoEnrollButton center].y)];
    } completion:^(BOOL finished) {
        [self.gotoLoginButton removeFromSuperview];
        [self.gotoEnrollButton removeFromSuperview];
        self.gotoLoginButton = nil;
        self.gotoEnrollButton = nil;
    }];
}

- (void) pushLoginViewIn{
    [UIView setAnimationDelay:0.1];
    [UIView animateWithDuration:0.5 animations:^{
        [self.loginView setCenter:CGPointMake(ScreenWidth/2, ScreenHeight/2)];
    } completion:^(BOOL finished) {
        nil;
    }];
}

- (void) loginAnimation{
    NSLog(@"Login");
    [self loginDisappear];
    [self pushLoginViewIn];
}

- (void) enrollAnimation{
    NSLog(@"Enroll");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
