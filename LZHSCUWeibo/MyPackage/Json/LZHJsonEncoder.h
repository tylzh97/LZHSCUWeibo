//
//  LZHJsonEncoder.h
//  MyDiarySliderVersion
//
//  Created by 李政浩 on 2018/5/14.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHJsonEncoder : NSObject


/**
 *  将 Json 转换成 NSDictionary
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  将 NSDictionary 转换成 Json
 *  dic : NSDictionary 对象
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

@end
