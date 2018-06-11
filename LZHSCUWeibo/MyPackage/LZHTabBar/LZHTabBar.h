//
//  LZHTabBar.h
//  UINavigationBar-DIY
//
//  Created by 李政浩 on 2018/6/5.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddingWeiboDelegate<NSObject>
@required

//弹出添加微博拟态串口代理
- (void) addWeibo;

@end

@interface LZHTabBar : UITabBar

@property (strong, nonatomic) id<AddingWeiboDelegate> lzhDeledate;

@property (strong, nonatomic) UIButton * plushBtn;

@property (assign, nonatomic) BOOL haveSetted;

@end
