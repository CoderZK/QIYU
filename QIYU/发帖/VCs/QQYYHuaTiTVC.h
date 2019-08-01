//
//  QQYYHuaTiTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void(^huaTiBlock)(NSArray * arr);

NS_ASSUME_NONNULL_BEGIN

@interface QQYYHuaTiTVC : BaseTableViewController

@property(nonatomic,copy)huaTiBlock htBlock;

@end

NS_ASSUME_NONNULL_END
