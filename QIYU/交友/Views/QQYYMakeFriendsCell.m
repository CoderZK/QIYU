//
//  QQYYMakeFriendsCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMakeFriendsCell.h"

@interface QQYYMakeFriendsCell()
@property(nonatomic,strong)UIButton *sexBt,*biaoQianOneBt,*biaoQianTwoBt;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UIImageView *huanGuanImgV;

@end

@implementation QQYYMakeFriendsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 55, 55);
        self.headBt.layer.cornerRadius = 5;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
//        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.headBt.tag = 100;
        //昵称
        self.nameLB =[[UILabel alloc] initWithFrame:CGRectMake(80, 20 , 120, 20)];
        self.nameLB.text = @"GAtsby";
        self.nameLB.font =[UIFont systemFontOfSize:14];
        self.nameLB.textColor = CharacterBlackColor;
        [self addSubview:self.nameLB];
        //性别
        self.sexBt = [[UIButton alloc] init];
        [self.sexBt setTitle:@"19" forState:UIControlStateNormal];
        self.sexBt.titleLabel.font = kFont(10);
        [self addSubview:self.sexBt];
        self.biaoQianOneBt = [[UIButton alloc] init];
//        [self addSubview:self.biaoQianOneBt];
        [self.biaoQianOneBt setTitle:@"19" forState:UIControlStateNormal];
        self.biaoQianOneBt.titleLabel.font = kFont(10);
        
        self.biaoQianTwoBt = [[UIButton alloc] init];
//        [self addSubview:self.biaoQianTwoBt];
        [self.biaoQianTwoBt setTitle:@"19" forState:UIControlStateNormal];
        self.biaoQianTwoBt.titleLabel.font = kFont(10);
        self.sexBt.frame = CGRectMake(CGRectGetMaxX(self.headBt.frame) + 15 , CGRectGetMaxY(self.nameLB.frame) + 5 , 40, 15);
        self.biaoQianOneBt.frame = CGRectMake(CGRectGetMaxX(self.sexBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40, 15);
        self.biaoQianTwoBt.frame = CGRectMake(CGRectGetMaxX(self.biaoQianOneBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40, 15);
        [self.biaoQianOneBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [self.biaoQianTwoBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        self.sexBt.clipsToBounds = self.biaoQianTwoBt.clipsToBounds = self.biaoQianOneBt.clipsToBounds = YES;
         self.biaoQianOneBt.hidden = self.biaoQianTwoBt.hidden = YES;
        //皇冠
        self.huanGuanImgV = [[UIImageView alloc] init];
        self.huanGuanImgV.size = CGSizeMake(17, 17);
        self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame)+5;
        self.huanGuanImgV.centerY = self.nameLB.centerY;
        self.huanGuanImgV.image =[UIImage imageNamed:@"huanguan"];
        [self addSubview:self.huanGuanImgV];
        //时间
        self.timeLB = [[UILabel alloc] init];
        self.timeLB.text = @"上海 05-06";
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = CharacterBackColor;
        [self addSubview:self.timeLB];
        self.timeLB.textAlignment = NSTextAlignmentRight;
        [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.headBt.mas_centerY).offset(-12);
            make.width.equalTo(@150);
            make.height.equalTo(@20);
        }];
        
        self.addressLB = [[UILabel alloc] init];
        self.addressLB.text = @"1.79km";
        self.addressLB.font = kFont(13);
        self.addressLB.textColor = CharacterBackColor;
        [self addSubview:self.addressLB];
        self.addressLB.textAlignment = NSTextAlignmentRight;
        
        [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.headBt.mas_centerY).offset(12);
            make.width.equalTo(@150);
            make.height.equalTo(@20);
        }];
        //状态
        self.typeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 135, 27.5, 120, 20)];
        self.typeLB.font = kFont(14);
        self.typeLB.textColor = CharacterRedColor;
        self.typeLB.textAlignment = NSTextAlignmentRight;
        self.typeLB.text = @"当前在线";
//        [self addSubview:self.typeLB];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(self.sexBt.frame) + 5, ScreenW - 95, 20)];
        self.contentLB.font = kFont(13);
        self.contentLB.textColor = CharacterBlackColor;
        self.contentLB.text = @"安静万分感激";
        [self addSubview:self.contentLB];
        
        
    }
    return self;
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
    
    self.contentLB.text = [NSString stringWithFormat:@"%@-%@",model.province,model.city];;
    
    
    CGFloat distace = [model.distance floatValue] * 1000;
    if (distace < 1000) {
        self.addressLB.text = [NSString stringWithFormat:@"%0.2fm",distace];
    }else {
        self.addressLB.text = [NSString stringWithFormat:@"%@km",model.distance];
    }
    
    if (self.isHot) {
        [self.timeLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headBt.mas_centerY);
        }];
        self.addressLB.hidden = YES;
    }else {
        self.addressLB.hidden = NO;
        [self.timeLB mas_updateConstraints:^(MASConstraintMaker *make) {
              make.centerY.equalTo(self.headBt.mas_centerY).offset(-12);
        }];
    }
    
    if (model.isOnline == 1) {
        self.timeLB.text = @"当前在线";
        self.timeLB.textColor = CharacterRedColor;
    }else {
        
        if ([model.outLineTime isEqualToString:@"0"]) {
            self.timeLB.text = @"离线";
            self.timeLB.textColor = CharacterBackColor;
        }else {
            self.timeLB.text = [NSString stringWithDateStr:model.outLineTime];
            self.timeLB.textColor = CharacterBackColor;
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
    
//    self.sexBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.sexBt andRadi:7.5];
//    self.biaoQianOneBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.biaoQianOneBt andRadi:7.5];
//    self.biaoQianTwoBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.biaoQianTwoBt andRadi:7.5];
    
}

- (void)setIsHot:(BOOL)isHot  {
    _isHot = isHot;
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
