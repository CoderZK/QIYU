//
//  QQYYMineFriendsCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMineFriendsCell.h"

@implementation QQYYMineFriendsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 55, 55);
        self.headBt.layer.cornerRadius = 27.5;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
        //        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.headBt.tag = 100;
        //昵称
        self.nameLB =[[UILabel alloc] initWithFrame:CGRectMake(80, 18 , 150, 20)];
        self.nameLB.text = @"GAtsby";
        [self.nameLB sizeToFit];
        self.nameLB.font =[UIFont systemFontOfSize:14 weight:0.2];
        self.nameLB.textColor = CharacterBlackColor;
        [self addSubview:self.nameLB];
        
        
        //性别
        self.sexBt = [[UIButton alloc] init];
        [self.sexBt setTitle:@"19" forState:UIControlStateNormal];
        self.sexBt.titleLabel.font = kFont(10);
        [self addSubview:self.sexBt];
        self.biaoQianOneBt = [[UIButton alloc] init];
        [self addSubview:self.biaoQianOneBt];
        [self.biaoQianOneBt setTitle:@"19" forState:UIControlStateNormal];
        self.biaoQianOneBt.titleLabel.font = kFont(10);
        
        self.biaoQianTwoBt = [[UIButton alloc] init];
        [self addSubview:self.biaoQianTwoBt];
        [self.biaoQianTwoBt setTitle:@"19" forState:UIControlStateNormal];
        self.biaoQianTwoBt.titleLabel.font = kFont(10);
        self.sexBt.frame = CGRectMake(CGRectGetMaxX(self.headBt.frame) + 15 , CGRectGetMaxY(self.nameLB.frame) + 10 , 40, 15);
        self.biaoQianOneBt.frame = CGRectMake(CGRectGetMaxX(self.sexBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40, 15);
        self.biaoQianTwoBt.frame = CGRectMake(CGRectGetMaxX(self.biaoQianOneBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40, 15);
        [self.biaoQianOneBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [self.biaoQianTwoBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        self.sexBt.clipsToBounds = self.biaoQianTwoBt.clipsToBounds = self.biaoQianOneBt.clipsToBounds = YES;
        self.biaoQianOneBt.hidden = self.biaoQianTwoBt.hidden = YES;
        
        //皇冠
        self.huanGuanImgV = [[UIImageView alloc] init];
        self.huanGuanImgV.size = CGSizeMake(17, 17);
        self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame);
        self.huanGuanImgV.centerY = self.nameLB.centerY;
        self.huanGuanImgV.image =[UIImage imageNamed:@"huanguan"];
        [self addSubview:self.huanGuanImgV];
        
     
        //心
        self.xinImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 45-15+10, 18, 25, 25)];
        self.xinImgV.image = [UIImage imageNamed:@"79"];
        [self addSubview:self.xinImgV];
        
        //状态
        self.typeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 45-15, CGRectGetMaxY(self.xinImgV.frame) + 2, 45, 20)];
        self.typeLB.font = kFont(14);
        self.typeLB.textColor = CharacterBlackColor;
        self.typeLB.textAlignment = NSTextAlignmentRight;
        self.typeLB.text = @"已关注";
        [self addSubview:self.typeLB];
        
        self.guanZhuBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 45-15 , 15 , 45, 45)];
        [self addSubview:self.guanZhuBt];
       
        self.onLineLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 135, 27.5, 120, 20)];
        self.onLineLB.font = kFont(14);
        self.onLineLB.textColor = CharacterRedColor;
        self.onLineLB.textAlignment = NSTextAlignmentRight;
        self.onLineLB.text = @"当前在线";
        [self addSubview:self.onLineLB];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(self.sexBt.frame) + 5, ScreenW - 95, 20)];
        self.contentLB.font = kFont(13);
        self.contentLB.textColor = CharacterBackColor;
        self.contentLB.text = @"甘肃省";
        [self addSubview:self.contentLB];
        
        
    }
    return self;
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 0 || type == 4) {
        self.xinImgV.hidden = self.typeLB.hidden = self.guanZhuBt.hidden = YES;
    }else if (type == 1 || type == 2 || type == 3) {
        self.xinImgV.hidden = self.typeLB.hidden = self.guanZhuBt.hidden = NO;
    }else {
       self.xinImgV.hidden = self.typeLB.hidden =  YES;
       self.guanZhuBt.hidden = NO;
        self.onLineLB.hidden = YES;
        [self.guanZhuBt  setImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
    }
}


- (void)setModel:(zkHomelModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:model.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = model.nickName;

    [self.nameLB sizeToFit];
    self.nameLB.height = 20;
    self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame) + 5;
    if (model.isVip) {
        self.huanGuanImgV.hidden = NO;
    }else {
        self.huanGuanImgV.hidden = YES;
    }
    
    self.contentLB.text =[NSString stringWithFormat:@"%@-%@",model.province, model.city];
    
    if (self.type == 0) {
        self.onLineLB.hidden = NO;
    }else {
        self.onLineLB.hidden = YES;
    }

    //关注字样的显示问题
    if (self.type ==2 || self.type == 3) {
        //粉丝
        if (model.subscribed) {
            self.typeLB.text = @"已关注";
            self.xinImgV.image = [UIImage imageNamed:@"79"];
        }else {
            self.typeLB.text = @"未关注";
            self.xinImgV.image = [UIImage imageNamed:@"31"];
        }
    }
    
    if (model.isOnline == 1) {
        self.onLineLB.text = @"当前在线";
        self.onLineLB.textColor = CharacterRedColor;
    }else {
        
        if ([model.outLineTime isEqualToString:@"0"]) {
            self.onLineLB.text = @"离线";
            self.onLineLB.textColor = CharacterBackColor;
        }else {
            self.onLineLB.text = [NSString stringWithDateStr:model.outLineTime];
            self.onLineLB.textColor = CharacterBackColor;
        }
        
        
    }
    if (self.type == 5) {
        if (model.isSelect) {
            [self.guanZhuBt setImage:[UIImage imageNamed:@"80"] forState:UIControlStateNormal];
        }else {
           [self.guanZhuBt setImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
        }
    }
    NSArray *  arr = [model.tags componentsSeparatedByString:@","];
    NSString * strTwo = @"";
    if (arr.count > 0) {
        strTwo = [NSString stringWithFormat:@"%@ %@ ∙ %@",[sxeArr objectAtIndex:model.gender],model.age,arr[0]];
    }
    if (arr.count > 1) {
        strTwo = [NSString stringWithFormat:@"%@ %@ ∙ %@ ∙ %@",[sxeArr objectAtIndex:model.gender],model.age,arr[0],arr[1]];
    }
    
    [self.sexBt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)model.gender + 89]] forState:UIControlStateNormal];
    //    NSString *sexStr = [NSString stringWithFormat:@"%@ %@",[sxeArr objectAtIndex:model.gender],model.age];
    [self.sexBt setTitle:strTwo forState:UIControlStateNormal];
    self.sexBt.mj_w = 15+ [strTwo getWidhtWithFontSize:10];
    self.sexBt.layer.cornerRadius  = 3;
    self.sexBt.clipsToBounds = YES;
    self.biaoQianTwoBt.hidden =  self.biaoQianOneBt.hidden = YES;
    
//    self.biaoQianTwoBt.hidden =  self.biaoQianOneBt.hidden = YES;
//    NSArray *  arr = [model.tags componentsSeparatedByString:@","];
//
//    if (arr.count > 0) {
//        self.biaoQianOneBt.hidden = NO;
//        [self.biaoQianOneBt setTitle:arr[0] forState:UIControlStateNormal];
//        self.biaoQianOneBt.mj_w = [arr[0] getWidhtWithFontSize:10] + 20 ;
//        self.biaoQianOneBt.mj_x = CGRectGetMaxX(self.sexBt.frame) + 10;
//    }
//
//    if (arr.count > 1) {
//        self.biaoQianTwoBt.hidden = NO;
//        [self.biaoQianTwoBt setTitle:arr[1] forState:UIControlStateNormal];
//        self.biaoQianTwoBt.mj_w = [arr[1] getWidhtWithFontSize:10] + 20;
//        self.biaoQianTwoBt.mj_x = CGRectGetMaxX(self.biaoQianOneBt.frame) + 10;
//    }
//
//    self.sexBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.sexBt andRadi:7.5];
//    self.biaoQianOneBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.biaoQianOneBt andRadi:7.5];
//    self.biaoQianTwoBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.biaoQianTwoBt andRadi:7.5];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
