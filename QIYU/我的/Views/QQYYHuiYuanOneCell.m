//
//  QQYYHuiYuanOneCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHuiYuanOneCell.h"

@implementation QQYYHuiYuanOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat spaceX = 10;
        CGFloat spaceY = 10;
        CGFloat ww = (ScreenW - 4*spaceX)/3;
        NSArray  * arr1 = @[@"帖子置顶",@"主页背景",@"谁看过我",@"个人相册",@"修改昵称",@"好友申请"];
        
        NSArray  * arr2 = @[@"提升推荐概率",@"可自定义背景",@"访客全纪录",@"额外扩张10张",@"修改无限制",@"发送无限制"];
        
        for (int i = 0 ; i< arr1.count; i++) {
        
            HuiYuanNeiButton * button = [[HuiYuanNeiButton alloc] initWithFrame:CGRectMake(spaceX + i%3 * (ww + spaceX), spaceY + i/3 *(100+ spaceY), ww, 100)];
            button.LB1.text = arr1[i];
            button.LB2.text = arr2[i];
            button.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"hhy%d",i+18]];
            [self addSubview:button];
            
        }
        
        
        
        
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end


@implementation HuiYuanNeiButton

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
 
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2 - 20 , 0, 40, 40)];
        [self addSubview:self.imgV];
        
        self.LB1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.width, 20)];
        self.LB1.font = kFont(14);
        self.LB1.textColor = CharacterBlack40;
        self.LB1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.LB1];
        
        self.LB2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.width, 20)];
        self.LB2.font = kFont(14);
        self.LB2.textColor = CharacterBackColor;
        self.LB2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.LB2];
        
    }
    return self;
}

@end
