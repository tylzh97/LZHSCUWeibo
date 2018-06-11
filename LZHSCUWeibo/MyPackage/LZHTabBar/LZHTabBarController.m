//
//  LZHTabBarController.m
//  UINavigationBar-DIY
//
//  Created by 李政浩 on 2018/6/5.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHTabBarController.h"

#import "LZHSliderViewController.h"

#import "WeiboViewController.h"
#import "WeiboSortByLikeViewController.h"
//#import "AddDiaryViewController.h"

#import "LZHAddWeiboViewController.h"

#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LZHTabBarController ()

@end

@implementation LZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LZHSliderViewController * sliderVC = [[LZHSliderViewController alloc] init];
    [sliderVC addChildViewController:[WeiboViewController new] withTitle:@"关注"];
    [sliderVC addChildViewController:[WeiboSortByLikeViewController new] withTitle:@"热门"];
    
    [self addViewController:sliderVC title:@"微博" image:@"home_liner@2x" selectedImage:@"home@2x"];
    [self addViewController:[UIViewController new] title:@"消息" image:@"message_liner@2x" selectedImage:@"message@2x"];
    [self addViewController:[UIViewController new] title:@"发现" image:@"search_liner@2x" selectedImage:@"search@2x"];
    [self addViewController:[UIViewController new] title:@"我的" image:@"user_liner@2x" selectedImage:@"user@2x"];
    
    
    [self setTabBarButton];
}

- (void) addViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *) selectedImage
{
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    nav.title = title;
    nav.tabBarItem.image = [self resizeUIImage:[UIImage imageNamed:image] withSize:CGSizeMake(30, 30)];
    
    nav.tabBarItem.selectedImage = [self resizeUIImage:[UIImage imageNamed:selectedImage] withSize:CGSizeMake(30, 30)];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    nav.tabBarItem.accessibilityFrame = CGRectMake(0, 0, screenSize.width, 49);
}

/*
- (void)addViewControllerWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *) selectedImage
{
    UIViewController * vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    nav.title = title;
    nav.tabBarItem.image = [self reSizeImage:[UIImage imageNamed:image] toSize:CGSizeMake(30, 30)];
    nav.tabBarItem.selectedImage = [self reSizeImage:[UIImage imageNamed:selectedImage] toSize:CGSizeMake(30, 30)];
}
 */


//重置图像大小的新方法测试
- (UIImage *) resizeUIImage:(UIImage *) img withSize:(CGSize) reSize{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, reSize.width, reSize.height);
    [btn setImage:img forState:UIControlStateNormal];
    [view addSubview:btn];
    
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)setTabBarButton{
    LZHTabBar * tabBar = [[LZHTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    tabBar.lzhDeledate = self;
}

- (void)addWeibo{
    LZHAddWeiboViewController * lzhAdd = [[LZHAddWeiboViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:lzhAdd];
    
    //nav.hidesBottomBarWhenPushed = YES;
    //弹出模态窗口
    [self presentViewController:nav animated:YES completion:nil];
}


/*
 - (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
 {
 UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
 // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
 vc.navigationItem.title = title;
 nav.tabBarItem.title = title;
 nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
 
 [self.mainTC addChildViewController:nav];
 }
 */


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
