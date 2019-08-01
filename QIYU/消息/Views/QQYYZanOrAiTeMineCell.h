//
//  QQYYZanOrAiTeMineCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYZanOrAiTeMineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property(nonatomic,assign)NSInteger type; // 0 @我的 1 收到的赞
@property(nonatomic,strong)QQYYTongYongModel *model;
@end

NS_ASSUME_NONNULL_END
