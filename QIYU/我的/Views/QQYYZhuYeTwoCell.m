//
//  QQYYZhuYeTwoCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYZhuYeTwoCell.h"

@implementation QQYYZhuYeTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        NSArray * arr = @[@"关注",@"粉丝",@"爱豆"];
        for (int i = 0; i < arr.count; i++) {
            
            UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake( 15 + (70 +10) * i,15, 70, 20)];
            lb.textColor = CharacterBlack40;
            lb.font = kFont(14);
            lb.tag = i+1000;
            lb.text = @"25";
            [self addSubview:lb];
            
            
            UILabel * lb2 =[[UILabel alloc] initWithFrame:CGRectMake(15 + (70 +10) * i, 35,70, 20)];
            lb2.textColor = CharacterBackColor;
            lb2.font = kFont(14);
            lb2.tag = i+1000;
            lb2.text = arr[i];
            [self addSubview:lb2];
            
            UIButton * button =[[UIButton alloc] initWithFrame:CGRectMake(15 + (70 +10) * i, 15, 70, 70)];
            button.tag = 200+i;
            [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
        
//        self.guanZhuBt = [[UIButton alloc] init];
//        self.guanZhuBt.layer.borderWidth = 0.5;
//        self.guanZhuBt.layer.borderColor = PurpleColor.CGColor;
//        self.guanZhuBt.titleLabel.font = kFont(13);
//        self.guanZhuBt.tag = 203;
//        [self addSubview:self.guanZhuBt];
//        [self.guanZhuBt mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.mas_centerY);
//            make.right.equalTo(@-15);
//            make.height.equalTo(@35);
//            make.width.equalTo(@70);
//        }];
        
//        self.cancelGuanZhuBt = [[UIButton alloc] init];
//        [self addSubview:self.cancelGuanZhuBt];
//        self.cancelGuanZhuBt.clipsToBounds = YES;
//        self.cancelGuanZhuBt.tag = 204;
//        [self.cancelGuanZhuBt setTitle:@"已关注" forState:UIControlStateNormal];
//        self.cancelGuanZhuBt.layer.borderColor = CharacterBlackColor.CGColor;
//        [self.cancelGuanZhuBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
//        self.cancelGuanZhuBt.titleLabel.font = kFont(13);
//        [self.cancelGuanZhuBt mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.left.right.equalTo(self.guanZhuBt);
//            make.bottom.equalTo(self.guanZhuBt.mas_top).offset(0);
//            make.height.equalTo(@(0));
//            
//        }];
//        
//        [self.cancelGuanZhuBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
//        [self.guanZhuBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}


- (void)action:(UIButton *)button {

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickGuanZhuOrFansWith:)]){
        [self.delegate didClickGuanZhuOrFansWith:button.tag - 200];
    }
    
    
    
}

- (void)setModel:(QQYYUserModel *)model {
    _model = model;
    UILabel * lb1 = (UILabel *)[self viewWithTag:1000];
    UILabel * lb2 = (UILabel *)[self viewWithTag:1001];
    UILabel * lb3 = (UILabel *)[self viewWithTag:1002];

    
    if (model.flowerNum > 10000) {
       lb3.text = [NSString stringWithFormat:@"%0.2f万",(long)model.flowerNum/10000.0];
    }else {
      lb3.text = [NSString stringWithFormat:@"%ld",(long)model.flowerNum];
    }
    
    if (model.subscribeNum > 10000) {
        lb1.text = [NSString stringWithFormat:@"%0.2f万",(long)model.subscribeNum/10000.0];
    }else {
       lb1.text = [NSString stringWithFormat:@"%ld",(long)model.subscribeNum];
    }
    
    if (model.fansNum>10000) {
       lb2.text = [NSString stringWithFormat:@"%0.2f万",(long)model.fansNum/10000.0];
    }else {
      lb2.text = [NSString stringWithFormat:@"%ld",(long)model.fansNum];
    }
    

    self.guanZhuBt.hidden = [[QQYYSignleToolNew shareTool].session_uid isEqualToString:model.userId];
    
    
    if (model.subscribed) {
        [self.guanZhuBt setTitle:@"已关注" forState:UIControlStateNormal];
        self.guanZhuBt.layer.borderColor = PurpleColor.CGColor;
        [self.guanZhuBt setTitleColor:PurpleColor forState:UIControlStateNormal];
    }else {
        [self.guanZhuBt setTitle:@"关注动态" forState:UIControlStateNormal];
        self.guanZhuBt.layer.borderColor = PurpleColor.CGColor;
        [self.guanZhuBt setTitleColor:PurpleColor forState:UIControlStateNormal];
    }
    
    
}

- (void)guanZhuAction:(UIButton *)button {
    
    self.model.subscribed = !self.model.subscribed;
   
    
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
