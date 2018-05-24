//
//  LZHMarco.h
//  ttteeestttt
//
//  Created by 李政浩 on 2018/5/12.
//  Copyright © 2018年 lzh. All rights reserved.
//

#ifndef LZHMarco_h
#define LZHMarco_h

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// RGB颜色
#define LZHRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LZHRGBA(R, G, B, A) [UIColor colorWithRed:(R)/255.f green:(G)/255.f blue:(B)/255.f alpha:(A)]
// 主题颜色
#define LZHDiaryThemeBlueColor LZHRGBColor(70, 130, 180)
#define LZHDisKeyboardButtonGrayColor   LZHRGBColor(201, 201, 201)


#endif /* LZHMarco_h */
