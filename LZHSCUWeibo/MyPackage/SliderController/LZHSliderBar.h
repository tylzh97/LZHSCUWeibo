//
//  LZHSliderBar.h
//
//
//  Created by 李政浩 on 2018/5/12.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZHMarco.h"

//声明代理协议
//一般,我们把代理和代理内容写在一起,但是此处,由于代理方法中有参数为委托类本身,因此需要将代理方法写在类接口下方.
//此处,类似于函数声明,仅仅起到声明代理方法的作用.
@protocol LZHSliderBarDelegate;


//声明类的公开接口
@interface LZHSliderBar : UIView

/**
 *  根据标题，在sliderBar上添加item
 */
- (void)addItemWithTitle:(NSString*)title;

/**
 *  传入当前controller的偏移位置
 */
- (void)sliderMoveToOffsetX:(CGFloat)x;

/**
 *   接收 LZHSliderBarDelegate 委托的对象
 */
@property (nonatomic,weak) id<LZHSliderBarDelegate> delegate;

@end

//此处为委托方法实际委托处.
@protocol LZHSliderBarDelegate <NSObject>

@optional

/**
 * 当 sliderBar 上的 button 被点击时,会触发此函数.
 */
- (void)sliderBar:(LZHSliderBar*)sliderBar didSelectedByIndex:(NSInteger)index;

@end







