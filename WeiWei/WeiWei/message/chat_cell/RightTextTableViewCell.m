//
//  RightTextTableViewCell.m
//  BDMapDemo
//
//  Created by tw001 on 14-9-29.
//  Copyright (c) 2014年 ESX. All rights reserved.
//

#import "RightTextTableViewCell.h"

@implementation RightTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)longPress:(UIGestureRecognizer *)ges
{
    if (ges.state == 1) {
        NSLog(@"长按开始 %d", (int)ges.state);
        [_delegate longPressBegin:_indexPath];
    }
    if (ges.state == 3) {
        NSLog(@"长按结束 %d", (int)ges.state);
        [_delegate longPressShowMenu:_indexPath];
    }
}

/// 设置消息内容
- (void)setMsgContent:(MsgObject *)msgObj
{
    for (UIView *sview in [_msgView subviews]) {
        if ([sview isKindOfClass:[M80AttributedLabel class]]) {
            [sview removeFromSuperview];
        }
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 1.0;
    [_msgView addGestureRecognizer:longPress];
    
    float orginX = self.contentView.frame.size.width - msgObj.msgLabel.frame.size.width - 70;
    msgObj.msgLabel.frame = CGRectMake(10, kTextTop, msgObj.msgLabel.frame.size.width, msgObj.msgRowHeight - kTextTop * 2);
    if (msgObj.delivery_status == 1 || msgObj.delivery_status == 4) {
        _failueBtn.hidden = YES;
        _activityView.hidden = NO;
        _activityView.frame = CGRectMake(orginX - 30, _activityView.frame.origin.y, 30, 30);
        [_activityView startAnimating];
        
    }else if (msgObj.delivery_status == 2) {
        _failueBtn.hidden = YES;
        _activityView.hidden = YES;
        [_activityView stopAnimating];
        
    }else if (msgObj.delivery_status == 3){
        _failueBtn.hidden = NO;
        _activityView.hidden = YES;
        _failueBtn.frame = CGRectMake(orginX - 30, _failueBtn.frame.origin.y, 30, 30);
        [_failueBtn addTarget:self action:@selector(clickResendMsg) forControlEvents:UIControlEventTouchUpInside];
        [_activityView stopAnimating];
    }
    _msgView.frame = CGRectMake(orginX, _msgView.frame.origin.y, msgObj.msgLabel.frame.size.width + 20, msgObj.msgRowHeight - kTextTop);
    _bgImageView.frame = CGRectMake(0, 0, _msgView.frame.size.width + 10, _msgView.frame.size.height);
    
    [_msgView addSubview:msgObj.msgLabel];
}

/// 获得高度
+ (float)getMsgHeight:(MsgObject *)msgObj
{
    return msgObj.msgRowHeight;
}

/// 点击重新发送消息
- (void)clickResendMsg
{
    [_delegate resendMsg:_rowIndex];
}

@end
