//
//  QQYYMineFriendsTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYMineFriendsTVC : BaseTableViewController
@property(nonatomic,strong)NSString *userNo;
@property(nonatomic,assign)NSInteger type;// 0 我的好友 1 关注  2 粉丝 3 谁看过我  4黑名单 // 5 添加好友
@end

NS_ASSUME_NONNULL_END
