//
//  lzhHash.h
//  lzhMD5Test
//
//  Created by 李政浩 on 2018/5/15.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface lzhHash : NSObject

+ (NSString *) md5:(NSString *)str;

@end
