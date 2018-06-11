//
//  LZHTabBar.m
//  UINavigationBar-DIY
//
//  Created by 李政浩 on 2018/6/5.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHTabBar.h"

@implementation LZHTabBar

- (void)layoutSubviews{

    CGRect sFrame = self.frame;
    
    //如果未设置过格式,则进行格式的设置
    if(!_haveSetted)
    {
        [super layoutSubviews];
        
        //NSLog(@"*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n");
        
        //如果是iPhone X,则将Tabbar的高度设置为49
        if(self.frame.size.height == 83){
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 49);
        }
        
        NSInteger num = self.items.count + 1;  // tabBarButton的个数
        CGFloat btnW = self.frame.size.width / num;
        CGFloat btnH = self.frame.size.height;
        // 调整tabBatButton的位置
        NSInteger i = 0;
        for (UIView * tabBarButton in self.subviews) {
            if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                
                if (i == 2) {   // 如果是第三个按钮则右移一个位置
                    i += 1;
                }
                tabBarButton.frame = CGRectMake(btnW*i, 0, btnW, btnH);
                i ++;
            }
        }
        self.tintColor = [UIColor blackColor];
        self.plushBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        
        //将标记设置为设置过
        _haveSetted = YES;
    }
    
    //将Tabbar的高度重设为原高度
    //每次改变frame,都会重掉此函数
    self.frame = sFrame;
}

- (UIButton *)plushBtn{
    if (_plushBtn == nil) {
        UIButton * plustBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _plushBtn = plustBtn;
        UIImage * addImage = [UIImage imageNamed:@"add"];
        //_plushBtn.frame = CGRectMake(0, 0, 46.4, 40);
        _plushBtn.frame = CGRectMake(0, 0, 40, 34.5);
        [_plushBtn setImage:addImage forState:UIControlStateNormal];
        //_plushBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //[_plushBtn setBackgroundImage:[self reSizeImage:[UIImage imageNamed:@"add"] toSize:CGSizeMake(46.4, 40)]   forState:UIControlStateNormal];
        //[_plushBtn setBackgroundImage:[self reSizeImage:[UIImage imageNamed:@"plus_liner"] toSize:CGSizeMake(40, 40)] forState:UIControlStateHighlighted];    // 高亮状态
        //[_plushBtn sizeToFit];  // 自适应图片的大小
        [_plushBtn addTarget:self action:@selector(btnPushed) forControlEvents:UIControlEventTouchUpInside];
        // 只添加一次
        [self addSubview:_plushBtn];
    }
    return _plushBtn;
}


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
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//向委托者发送请求,请求弹出模态窗口
- (void) btnPushed
{
    [self.lzhDeledate addWeibo];
}


- (void)setItems:(NSArray<UITabBarItem *> *)items{
    for (NSInteger i=0; i<items.count; i++) {
        NSLog(@"%@", [items objectAtIndex:i].title);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
