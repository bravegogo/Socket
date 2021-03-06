//
//  RightVoiceTableViewCell.m
//  BDMapDemo
//
//  Created by tw001 on 14-9-29.
//  Copyright (c) 2014年 ESX. All rights reserved.
//

#import "RightVoiceTableViewCell.h"

@implementation RightVoiceTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceBtn addTarget:self action:@selector(clickPlayVoice:) forControlEvents:UIControlEventTouchUpInside];
        [_msgView addSubview:_voiceBtn];
        
        _voiceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SenderVoiceNodePlaying"]];
        [_voiceBtn addSubview:_voiceImage];
        _voiceBtn.layer.cornerRadius = 5.0f;
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor darkGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:13.0f];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_timeLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/// 播放语音
- (void)clickPlayVoice:(UIButton *)btn
{
    [_delegate playVoice:_indexPath];
}

/// 设置消息内容
- (void)setMsgContent:(MsgObject *)msgObj
{
    _bgImageView.alpha = 1;
    _timeLabel.hidden = NO;
    _voiceImage.hidden = NO;
    float timeWidth = 16.0f;
    if (msgObj.voice_time >= 10) {
        timeWidth = 24.0f;
    }
    _timeLabel.text = [NSString stringWithFormat:@"%d\"", msgObj.voice_time];
    float voiceWidth = 40.0f;
    if (msgObj.voice_time > 1) {
        voiceWidth = voiceWidth + msgObj.voice_time * 2.66f;
    }
    float orginX = self.contentView.frame.size.width - 55 - voiceWidth - timeWidth;
    if (msgObj.delivery_status == 1) {
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
    }else{
        _failueBtn.hidden = YES;
        _timeLabel.hidden = YES;
        _voiceImage.hidden = YES;
        _activityView.hidden = YES;
        _activityView.frame = CGRectMake(orginX - 30, _activityView.frame.origin.y, 30, 30);
    }
    _timeLabel.frame = CGRectMake(orginX, 20, timeWidth, 20);
    _msgView.frame = CGRectMake(orginX + timeWidth, _msgView.frame.origin.y, voiceWidth + 15, 40);
    _bgImageView.frame = CGRectMake(0, 0, voiceWidth + 15, 40);
    _voiceBtn.frame = CGRectMake(4, 1.5, _msgView.frame.size.width - 18, _msgView.frame.size.height - 3);
    _voiceImage.frame = CGRectMake(_voiceBtn.frame.size.width - 25, 9, 20, 20);
}

/// 获得高度
+ (float)getMsgHeight:(MsgObject *)msgObj
{
    return 50.0f;
}

/// 点击重新发送消息
- (void)clickResendMsg
{
    [_delegate resendMsg:(int)_indexPath.row];
}

@end
