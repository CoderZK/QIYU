//
//  QQYYNewsOneCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYNewsOneCell.h"
#import "QQYYHomeOneCell.h"
@implementation QQYYNewsOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat ww = 80;
        CGFloat spaceBt = (ScreenW - 4*ww)/5;
        
        NSArray * arr = @[@"新朋友",@"评论消息",@"@我的信息",@"赞"];
        for (int i  = 0 ; i < arr.count; i++) {
            
            btView  * vv  = [[btView alloc] initWithFrame:CGRectMake(spaceBt + (i % 4) * (spaceBt + ww)  ,i/4 * (ww + 10 ) + 10 ,ww, ww)];
            vv.tag = i + 100;
            vv.titleLB.text = arr[i];
            vv.bt.tag = i;
            vv.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"qy%d",i+79]];
            [vv.bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:vv];
            
        }
        
        
    }
    return self;
}


- (void)setModel:(QQYYTongYongModel *)model {
    _model = model;
    
    btView * v1 =[self viewWithTag:100];
    btView * v2 =[self viewWithTag:101];
    btView * v3 =[self viewWithTag:102];
    btView * v4 =[self viewWithTag:103];
    
    [v1.numberBt setNumber:model.FriendMsg andFont:10];
    [v2.numberBt setNumber:model.ReplyMsg andFont:10];
    [v3.numberBt setNumber:model.AtMsg andFont:10];
    [v4.numberBt setNumber:model.LikeMsg andFont:10];

}

- (void)clickAction:(UIButton *)button {
 
    
    if (self.clickIndexBlock != nil) {
        self.clickIndexBlock(button.tag);
    }
    
    
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
