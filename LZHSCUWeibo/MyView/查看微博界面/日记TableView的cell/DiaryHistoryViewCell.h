//
//  DiaryHistoryViewCell.h
//  MyDiary
//
//  Created by 李政浩 on 2018/5/9.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LZHCellContentView.h"

@interface DiaryHistoryViewCell : UITableViewCell


@property (strong, nonatomic) NSDictionary *dicDate;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *weather;
@property (strong, nonatomic) NSString *emotion;

@property (strong, nonatomic) LZHCellContentView *cellContentView;

@end
