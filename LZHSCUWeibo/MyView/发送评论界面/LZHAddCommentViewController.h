//
//  LZHAddCommentViewController.h
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/5.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZHWeiboTextView.h"

@interface LZHAddCommentViewController : UIViewController <NSURLConnectionDataDelegate>

@property (strong, nonatomic) UITextView * weiboField;

@property (strong, nonatomic) UISwipeGestureRecognizer * recognizer;

@property (assign, nonatomic) NSInteger weiboID;

@end
