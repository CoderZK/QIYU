//
//  QQYYZhuYeOneCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYZhuYeOneCell : UITableViewCell
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UILabel *contentLB;
@property(nonatomic,strong)UILabel *typeLB;
@property(nonatomic,strong)UIButton *sexBt,*biaoQianOneBt,*biaoQianTwoBt,*guanZhuBt;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UIImageView *huanGuanImgV,*xinImgV;
@property(nonatomic,strong)QQYYUserModel *userModel;
@end

NS_ASSUME_NONNULL_END
