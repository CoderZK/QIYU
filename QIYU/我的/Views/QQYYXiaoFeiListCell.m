//
//  QQYYXiaoFeiListCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYXiaoFeiListCell.h"

@implementation QQYYXiaoFeiListCell

- (void)setType:(NSInteger)type {
    _type = type;
    
    if (type == 0) {
        self.typeLB.hidden = YES;
        self.moneyLB.text = @"-5元";
        self.titleLB.text = @"送10个爱豆";
    }else {
       
        
        
    }
    
    
    
}


- (void)setModel:(QQYYTongYongModel *)model {
    _model = model;
    
    self.timeLB.text = [NSString stringWithTime:model.createTime];
    self.titleLB.text = model.title;
    
    if ([model.orderType integerValue] == 4 || [model.orderType integerValue] == 6) {
        
        self.moneyLB.text = [NSString stringWithFormat:@"+ %@爱豆",model.orderFee];
        
    }else {
        if ([model.orderType integerValue] == 1 || [model.orderType integerValue] == 2) {
            self.moneyLB.text = [NSString stringWithFormat:@"- %@元",model.orderFee];
        }else {
            self.moneyLB.text = [NSString stringWithFormat:@"- %@爱豆",model.orderFee];
        }
    }
    
    if (model.status == 1) {
        self.typeLB.text = @"待支付";
    }else if (model.status == 2) {
        self.typeLB.text = @"已支付";
    }else if (model.status == 3) {
        self.typeLB.text = @"已完成";
    }else if (model.status == 4) {
        self.typeLB.text = @"已取消";
    }else if (model.status == 5) {
        self.typeLB.text = @"已退款";
    }else if (model.status == 6) {
        self.typeLB.text = @"已关闭";
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
