//
//  QQYYXiaoFeiListCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYXiaoFeiListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *orderLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;

@property(nonatomic,strong)QQYYTongYongModel *model;



@property(nonatomic,assign)NSInteger type;




@end

NS_ASSUME_NONNULL_END
