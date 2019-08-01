//
//  QQYYMineFriendsCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYMineFriendsCell : UITableViewCell
@property(nonatomic,strong)UIButton *headBt; //头像
@property(nonatomic,strong)UILabel *contentLB;//内容
@property(nonatomic,strong)UILabel *typeLB; // 是否关注
@property(nonatomic,strong)UIButton *sexBt,*biaoQianOneBt,*biaoQianTwoBt,*guanZhuBt;
@property(nonatomic,strong)UILabel *nameLB; //昵称
@property(nonatomic,strong)UIImageView *huanGuanImgV,*xinImgV;
@property(nonatomic,assign)NSInteger type; //0 好友 1 关注 2 粉丝 3 谁看过我  4 我的黑名单 5 通讯录
@property(nonatomic,strong)UILabel *onLineLB;
@property(nonatomic,strong)zkHomelModel *model;


@end

NS_ASSUME_NONNULL_END
