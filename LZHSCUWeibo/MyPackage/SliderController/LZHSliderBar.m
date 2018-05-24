//
//  LZHSliderBar.m
//
//
//  Created by 李政浩 on 2018/5/12.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHSliderBar.h"

#define LZH_ITEMCOLOR_NORMAL [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1]
#define LZH_ITEMCOLOR_SELECTED [UIColor colorWithRed:111.0/255 green:68.0/255 blue:28.0/255 alpha:1]
#define LZH_SLIDER_COLOR [UIColor colorWithRed:162.0/255 green:219.0/255 blue:246.0/255 alpha:1]
#define LZH_ITEMBUTTON_WIDTH 60
#define LZH_SLIDER_HEIGHT 5
#define LZH_SLIDER_LENGTH 40

//声明本类的接口
@interface LZHSliderBar()

/**
 *  sliderItems, 为所有视图对象Button
 */
@property (nonatomic,strong) NSMutableArray* itemButtons;

/**
 *  为下方的滑动条, 主要用作动画的执行
 */
@property (nonatomic,weak) CALayer* sliderLayer;

/**
 *  当前视图控制器索引编号
 */
@property (nonatomic,assign) NSInteger currentIndex;
@end

//实现
@implementation LZHSliderBar

//为所有视图对象 sliderItems 的 get 方法.
- (NSMutableArray*)itemButtons{
    if(!_itemButtons) {
        _itemButtons = [NSMutableArray array];
    }
    return _itemButtons;
}

//为滑块层
- (CALayer*)sliderLayer{
    //若没有初始化滑块
    if(!_sliderLayer) {
        //创建并初始化 layer 对象
        CALayer* layer = [[CALayer alloc] init];
        [self.layer addSublayer:layer];
        _sliderLayer = layer;
        
        //将图层的边框设置为圆角,且圆角的半径为4
        layer.cornerRadius = 4;
        //设置滑动条的背景颜色
        layer.backgroundColor = LZH_SLIDER_COLOR.CGColor;
        //设置滑块位置
        layer.position = CGPointMake(0, self.bounds.size.height - LZH_SLIDER_HEIGHT / 2);
        layer.zPosition = NSIntegerMax;
    }
    return _sliderLayer;
}

//重写的类方法,使用 frame 初始化滑动条 view
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //设置滑动条的背景颜色,当前为230灰色.
        self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
    return self;
}

//为 UIView 的方法,在此处继承
//触发条件:
/*
  1、init初始化不会触发layoutSubviews，但是是用 initWithFrame 进行初始化时，当rect的值 非CGRectZero时,也会触发。
 
  2、addSubview会触发layoutSubviews
 
  3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 
  4、滚动一个UIScrollView会触发layoutSubviews
 
  5、旋转Screen会触发父UIView上的layoutSubviews事件
 
  6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
//此处,在调用完 initWithFrame 后系统自动调用该方法,对子视图进行布局
//addSubview 时会调用此函数
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //若没有界面按钮,则直接返回
    if( self.itemButtons.count == 0) return;
    
    //获取界面按钮数目
    NSInteger count = self.itemButtons.count;
    
    CGFloat itemW = self.frame.size.width/(CGFloat)count;
    CGFloat itemH = self.bounds.size.height;
    CGFloat itemY = 0;

    
    // 遍历已添加到bar上的item，更新其位置
    for (NSInteger i = 0; i < count; i++) {
        UIButton* itemButton = self.itemButtons[i];
        CGFloat itemX = i * itemW ;
        itemButton.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }
    
    
    // 设置layer的大小
    self.sliderLayer.bounds = CGRectMake(0, 0, LZH_SLIDER_LENGTH, LZH_SLIDER_HEIGHT);
    
    // 更新slider的位置
    UIButton* currItem = [self.itemButtons objectAtIndex:self.currentIndex];
    [self sliderMoveToX:currItem.center.x];
}

/**
 *  根据文本，在sliderBar上添加item
 */
- (void)addItemWithTitle:(NSString*)title {
    
    //创建itemButton
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:LZH_ITEMCOLOR_NORMAL forState:UIControlStateNormal];
    [button setTitleColor:LZHDiaryThemeBlueColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    //此句话会触发布局子布局函数!
    [self addSubview:button];
    
    //将 button 的 tag 值设置为 button 的位置编号(既 button 的数目)
    button.tag = self.itemButtons.count;
    //向 itemButtons 添加刚刚创建的 Button 对象指正
    [self.itemButtons addObject:button];
    
    if(self.itemButtons.count == 1) {
        //所添加 ButtonItems 后,只有一个 items ,则将第0个设置为被选中状态.
        [self didSelectedItem:0];
    }
}

/**
 *  SliderBarItem 点击时
 */
- (void)itemClick:(UIButton*)item {
    //将当前编号设置为点击对象的编号(既 tag 值)
    self.currentIndex = item.tag;
    
    //将 slider 移动至响应 button 所在的位置
    [self sliderMoveToX:item.center.x];
    
    //向代理对象发送消息
    //respondsToSelector:@selector 方法用于判断某个对象是否被代理.若被代理则返回真,否则返回假.用于防止调用时出现错误.
    if([self.delegate respondsToSelector:@selector(sliderBar:didSelectedByIndex:)]){
        [self.delegate sliderBar:self didSelectedByIndex:item.tag];
    }
}

/**
 *  计算scrollView在屏幕中的偏移位置相对于sliderBar的宽度所对应的X
 *  此方法为公开方法,用于给 sliderView 调用,传入 sliderView 的实时位移量,从而计算 sliderBar 的相对位移量.
 */
- (void)sliderMoveToOffsetX:(CGFloat)x {
    
    // 两个按钮中心点之间的间距
    
    UIButton* itemButton1 = [self.itemButtons firstObject];

    CGFloat buttonWidth = itemButton1.frame.size.width;
    
    CGFloat absX = itemButton1.center.x + x/[UIScreen mainScreen].bounds.size.width * buttonWidth;
    
    [self sliderMoveToX:absX];
    
    //当滑块滑动到某个 button 范围内时(既超过一半时), 将对应的 button 设置为被选中状态
    [self didSelectedItem:(int)absX/buttonWidth];
}

/**
 *  slider在slider中移动到x的位置
 */
- (void)sliderMoveToX:(CGFloat)x {
    // 创建动画(关键帧)
    /*
     duration    动画的时长
     repeatCount    重复的次数。不停重复设置为 HUGE_VALF
     repeatDuration    设置动画的时间。在该时间内动画一直执行，不计次数。
     beginTime    指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
     timingFunction    设置动画的速度变化
     autoreverses    动画结束时是否执行逆动画
     fromValue    所改变属性的起始值
     toValue    所改变属性的结束时的值
     byValue    所改变属性相同起始值的改变量
     */
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    // slider移动到 x
    pathAnimation.toValue = @(x);
    // 动画事件
    pathAnimation.duration = 0.3f;
    // 动画执行玩后 不删除动画
    pathAnimation.removedOnCompletion = NO;
    // 动画结束后,将 layer 保持动画最后运动的状态
    pathAnimation.fillMode = kCAFillModeForwards;
    // 动画效果 : 全速开始后慢慢停止
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // 执行动画
    [self.sliderLayer addAnimation:pathAnimation forKey:nil];
}

/**
 *  选中Item
 */
- (void)didSelectedItem:(NSInteger)itemIndex{
    //设置当前界面索引为按钮索引
    self.currentIndex = itemIndex;
    //将被选中的 buttonItem 设置为被选中的状态
    for (int i = 0; i < self.itemButtons.count; i++) {
        if(i != itemIndex) {
            [self.itemButtons[i] setSelected:NO];
        }else{
            [self.itemButtons[i] setSelected:YES];
        }
    }
}


@end
