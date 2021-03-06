//
//  TimeTableViewCell.m
//  LeiRen
//
//  Created by tw001 on 14-9-17.
//  Copyright (c) 2014年 wave. All rights reserved.
//

#import "TimeTableViewCell.h"
#import "WSocket.h"

@implementation TimeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CELL_WIDTH;
        
        self.contentView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = COLOR(206, 206, 206, 1);
        if (isIos7) {
            _timeLabel.backgroundColor = [UIColor clearColor];
        }
        _timeLabel.layer.backgroundColor = [[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1] CGColor];
        _timeLabel.layer.cornerRadius = 3.0f;
        _timeLabel.layer.borderWidth = 1;
        _timeLabel.layer.borderColor = [[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1] CGColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_timeLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/// 设置消息内容
- (void)setMsgContent:(NSString *)timeStr
{
    _timeLabel.text = timeStr;
    CGSize aSize = [Common getContentSize:timeStr withCGSize:CGSizeMake(10000, 20) withSystemFontOfSize:14.0f];
    _timeLabel.frame = CGRectMake((self.contentView.frame.size.width - (aSize.width + 10)) / 2, 5, aSize.width + 10, 20);
}

/// 获得高度
+ (float)getMsgHeight
{
    return 30.0f;
}

@end
