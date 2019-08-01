//
//  QQYYShouDaoDePingLunCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYShouDaoDePingLunCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *contentTwoLB;
@property (weak, nonatomic) IBOutlet UIButton *huiFuBt;

@property(nonatomic,strong)QQYYTongYongModel *model;

@end

NS_ASSUME_NONNULL_END
