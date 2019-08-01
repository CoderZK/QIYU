//
//  QQYYTaskTCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYTaskTCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property(nonatomic,strong)QQYYTongYongModel *model;
@end

NS_ASSUME_NONNULL_END
