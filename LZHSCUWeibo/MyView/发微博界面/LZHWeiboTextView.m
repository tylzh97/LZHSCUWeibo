//
//  LZHWeiboTextView.m
//  LZHSCUWeibo
//
//  Created by 李政浩 on 2018/6/5.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHWeiboTextView.h"

@implementation LZHWeiboTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [_recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
        [self addGestureRecognizer:_recognizer];
    }
    return self;
}

- (void) drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, screenSize.width,34)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.width - 50, 5, 40, 25)];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.layer.borderWidth =1;
    button.layer.cornerRadius =3;
    [bar addSubview:button];
    self.inputAccessoryView = bar;
    
    [button addTarget:self action:@selector(hiddenKeyboard)forControlEvents:UIControlEventTouchUpInside];

}

- (void) hiddenKeyboard {
    NSLog(@"-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+");
    [self endEditing:YES];
    [self resignFirstResponder];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"swipe down");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
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
