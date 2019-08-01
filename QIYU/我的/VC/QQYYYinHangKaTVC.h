//
//  QQYYYinHangKaTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYYinHangKaTVC : BaseTableViewController
@property(nonatomic,copy)void(^sendCarBlock)(QQYYTongYongModel *model);
@end

NS_ASSUME_NONNULL_END
