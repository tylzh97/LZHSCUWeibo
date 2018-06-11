//
//  LZHSliderViewController.m
//
//
//  Created by 李政浩 on 2018/5/12.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHSliderViewController.h"


//被委托者需要声明自己实现了委托里的协议.
//本类 LZHSliderViewController 声明自己要实现 UIScrollViewDelegate 和 LZHSliderBarDelegate 中的协议
@interface LZHSliderViewController() <UIScrollViewDelegate, LZHSliderBarDelegate>

/**
 *  子控制器滑动所在的contentScrollView
 */
@property (nonatomic,weak) UIScrollView * contentScrollView;

@end

//具体实现
@implementation LZHSliderViewController

//重写的初始化方法.
- (instancetype)init {
    self = [super init];
    if(self) {
        [self loadUI];
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

//加载页面时调用的方法.
-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //self.title = @"苟利国家生死以";
    
    if([self.defaults objectForKey:@"UserName"] == nil){
        NSLog(@"未登录!");
        //LZHLoginViewController * loginView = [LZHLoginViewController new];
        //[self presentViewController:loginView animated:YES completion:nil];
    }
}

//加载 UI. 在初始化过程中被调用.
- (void)loadUI {
    // 加载子contentScrollView
    [self loadContentScrollView];
    
    // 加载滑块
    [self loadSilderBar];
    
    // ios7+ 将导航控制器内的子控制器移动到导航栏的下方
    
    
    //阻止 view 延伸至整个屏幕
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //是否允许自动跳转 scrollView 的 inset 值,此处选择为不允许.
    //这个属性我不理解,如果将这个属性改为默认的 YES, 程序就会崩溃
    self.automaticallyAdjustsScrollViewInsets = NO;
}


/**
 *  创建sliderBar
 *  在 loadUI 中被调用,用于加载滑块
 */
- (void)loadSilderBar {
    CGSize screenSize  = [UIScreen mainScreen].bounds.size;
    
    // 创建SliderBar并设置大小 应该使用autolayout
    LZHSliderBar* sliderBar = [[LZHSliderBar alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    sliderBar.backgroundColor = [UIColor clearColor];
    self.sliderBar = sliderBar;
    self.sliderBar.delegate = self;
    self.navigationItem.titleView = self.sliderBar;
    
    UIBarButtonItem *settingBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[self reSizeImage:[UIImage imageNamed:@"setting"] toSize:CGSizeMake(30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(modalSetting:)];
    self.navigationItem.leftBarButtonItem = settingBarButtonItem;
    
    //设置毛玻璃效果,反正我是没看出来
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    
    //添加设置按钮.
    /*
    self.settingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.settingButton.frame  = CGRectMake(0, 0, 30, 30);
    [self.settingButton setCenter:CGPointMake(35, sliderBar.center.y+5)];
    [self.settingButton setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [self.settingButton addTarget:self action:@selector(modalSetting:) forControlEvents:UIControlEventTouchUpInside];
    //[self.settingButton setBackgroundColor:[UIColor redColor]];
    [navBarView addSubview:self.settingButton];
    */
    
    /*
    self.vcDiscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [self.vcDiscribeLabel setText:@"日记"];
    [self.vcDiscribeLabel setTextColor:LZHDiaryThemeBlueColor];
    [self.vcDiscribeLabel setCenter:CGPointMake(screenSize.width/2, navBarView.frame.size.height-20)];
    [self.vcDiscribeLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:25]];
    self.vcDiscribeLabel.textAlignment = NSTextAlignmentCenter;
    //[self.vcDiscribeLabel setBackgroundColor:[UIColor redColor]];
    [navBarView addSubview:self.vcDiscribeLabel];
     */
}

//重置图像大小
//苹果的ItemButton上的图像必须重置为与按钮大小等大才可.这种设计不统一很可能是由错误的设计造成的.
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void) modalSetting:(UIButton *) settingButton{
    ZFSettingViewController * settingView = [ZFSettingViewController new];
    UINavigationController * settingNav = [[UINavigationController alloc] initWithRootViewController:settingView];
    
    [settingNav.navigationBar setBarTintColor:LZHDiaryThemeBlueColor];
    
    /////////////////LZHMark!!!!此处有待改进!
    UIButton * myBtn;
    myBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myBtn.frame  = CGRectMake(0, 0, 30, 30);
    [myBtn setCenter:CGPointMake(35, 30)];
    UIImageView * btnImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    btnImg.image = [UIImage imageNamed:@"no"];
    [myBtn addSubview:btnImg];
    //[btnImg setCenter:CGPointMake(12, 12)];
    //[myBtn setImage:[UIImage imageNamed:@"no"] forState:UIControlStateNormal];
    [myBtn addTarget:self action:@selector(modalSetting:) forControlEvents:UIControlEventTouchUpInside];
    //[myBtn setBackgroundColor:[UIColor greenColor]];
    [myBtn addTarget:self action:@selector(closeModal:) forControlEvents:UIControlEventTouchUpInside];
    settingView.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:myBtn];

    
    
    [self presentViewController:settingNav animated:YES completion:nil];
}

- (void) closeModal: (UIButton *) btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  创建contentScrollView
 *  在 loadUI 中被调用,用于加载 contenScrollView
 */
- (void)loadContentScrollView {
    // 创建子控制器的scrollView， 和主View重叠
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.contentScrollView = scrollView;
    
    // 代理
    scrollView.delegate = self;
    
    // 边距 0
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 偏移 0
    scrollView.contentOffset = CGPointMake(0, 0);
    
    // 取消弹性效果
    scrollView.bounces = NO;
    
    // 取消滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // 翻页
    scrollView.pagingEnabled = YES;
    
    [self.view addSubview:scrollView];
}

/**
 *  在添加子控制器时，排列新的子控制器
 */
- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *) title {
    [super addChildViewController:childController];
    
    
    [self layoutSubViewController:title];
}

- (void)layoutSubViewController:(NSString *) title {
    
    CGFloat maxX = 0;
    
    if(self.childViewControllers.count > 1){
        // 获取倒数第二个控制器
        UIViewController* lastTwoVC = self.childViewControllers[self.childViewControllers.count - 2];
        // 返回矩形右边缘的坐标
        maxX = CGRectGetMaxX(lastTwoVC.view.frame);
    }
    
    // 获得最新添加的vc
    UIViewController* lastVc = [self.childViewControllers lastObject];
    // 添加到scrollView
    [self.contentScrollView addSubview:lastVc.view];
    
    // 设置位置
    CGRect vcFrame = lastVc.view.frame;
    vcFrame.origin.x = maxX;
    vcFrame.origin.y = 0;
    lastVc.view.frame = vcFrame;
 
    // 更新content的大小
    CGSize contentSize = self.contentScrollView.contentSize;
    contentSize.width = CGRectGetMaxX(lastVc.view.frame);
    self.contentScrollView.contentSize = contentSize;
    
    // slider添加标题
    // 向 slider 中添加新的 buttonItems
    [self.sliderBar addItemWithTitle:title];
}


#pragma mark - ScrollView代理

//滚动 scorll 时会触发此方法.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //将 sliderBar 的 slider 位移量进行相应的设置
    [self.sliderBar sliderMoveToOffsetX:scrollView.contentOffset.x];
    
    //设置 Label 的颜色,逐渐透明直至消失.
    [self.vcDiscribeLabel setTextColor:[UIColor colorWithRed:70/255.0 green:130/255.0 blue:180/255.0 alpha:( 1.0-(scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width) )]];
}

#pragma mark - LZHSliderBar代理

//sliderBar 上的按钮被点击会触发此函数.
- (void)sliderBar:(LZHSliderBar *)sliderBar didSelectedByIndex:(NSInteger)index {
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.view.frame.size.width * index;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.contentScrollView.contentOffset = offset;
    }];
}


@end
