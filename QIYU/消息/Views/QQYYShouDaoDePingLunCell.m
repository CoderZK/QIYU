//
//  QQYYShouDaoDePingLunCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYShouDaoDePingLunCell.h"

@implementation QQYYShouDaoDePingLunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.huiFuBt.layer.cornerRadius = 3;
    self.huiFuBt.clipsToBounds = YES;
    
    self.headBt.layer.cornerRadius = 5;
    self.headBt.clipsToBounds = YES;
//    self.nameLB.text = @"等你来玩啊";
    
//    NSString * str = @"评论我的回帖: 怎么打不出去";
//    self.contentTwoLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 7)];
//    self.contentLB.textColor = CharacterBlackColor;
//    self.contentLB.text = @"你是男是女啊, 一起玩啊";
    
}

- (void)setModel:(QQYYTongYongModel *)model {
    _model = model;

    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:model.replyUserAvatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = model.replyUserNickName;
    self.timeLB.text = [NSString stringWithTime:model.createTime];
    self.contentLB.text = model.content;
    self.contentLB.textColor = CharacterBlackColor;
    NSString * str = @"";
    if (model.replyId.length == 0) {
        str = [NSString stringWithFormat:@"评论我的回帖: %@",model.userContent];
    }else {
        str = [NSString stringWithFormat:@"评论我的评论: %@",model.userContent];
    }
    self.contentTwoLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 7)];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
