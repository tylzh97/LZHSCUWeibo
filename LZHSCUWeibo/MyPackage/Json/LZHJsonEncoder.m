//
//  LZHJsonEncoder.m
//  MyDiarySliderVersion
//
//  Created by 李政浩 on 2018/5/14.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "LZHJsonEncoder.h"

@implementation LZHJsonEncoder

/*!
 
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString  andSource:(NSString *) source{
    
    NSLog(@"%@", source);
    
    if (jsonString == nil || [jsonString  isEqual: @""] || !jsonString) {
        
        return nil;
        
    }
    
    
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"%@", jsonData);
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    NSLog(@"%@", source);
    
    return dic;
    
}



+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
