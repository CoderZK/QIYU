//
//  QQYYTongXunLuTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYTongXunLuTVC : BaseTableViewController
@property(nonatomic,copy)void(^sendFriendsBlock)(NSString * nickNameStr,NSString *idStr);
@property(nonatomic,strong)NSArray *arr;
@end

NS_ASSUME_NONNULL_END
