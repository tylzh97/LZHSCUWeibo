//
//  DiaryView.h
//  MyDiary
//
//  Created by 李政浩 on 2018/5/7.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface DiaryView : UIViewController<LZHSocketDelegate>

@property (strong, nonatomic) AppDelegate * appDelegate;

@end
