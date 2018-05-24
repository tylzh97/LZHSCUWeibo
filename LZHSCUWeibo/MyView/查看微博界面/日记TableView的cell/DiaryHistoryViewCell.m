//
//  DiaryHistoryViewCell.m
//  MyDiary
//
//  Created by 李政浩 on 2018/5/9.
//  Copyright © 2018年 lzh. All rights reserved.
//

#import "DiaryHistoryViewCell.h"

#define LZHScreenWidth [UIScreen mainScreen].bounds.size.width



@implementation DiaryHistoryViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.cellContentView = [[LZHCellContentView alloc] initWithFrame:CGRectMake(8, 8, LZHScreenWidth - 16, 74)];
        [self.contentView addSubview:self.cellContentView];
        
    }
    return self;
}

//prepareForReuse
- (void)prepareForReuse{
    [super prepareForReuse];
}

- (void)setDicDate:(NSDictionary *)dicDate {
    if (dicDate) {
        _dicDate = dicDate;
        _cellContentView.dicDate = dicDate;
    }
}

- (void)setTitle:(NSString *)title {
    if (title) {
        _title = title;
        _cellContentView.title = title;
    }
}

- (void)setDetail:(NSString *)detail {
    if (detail) {
        _detail = detail;
        _cellContentView.detail = detail;
    }
}

- (void)setEmotion:(NSString *)emotion {
    if (emotion) {
        _emotion = emotion;
        _cellContentView.emotion = emotion;
    }
}

- (void)setWeather:(NSString *)weather {
    if (weather) {
        _weather = weather;
        _cellContentView.weather = weather;
    }
}

@end
