//
//  QQYYDetailTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYDetailTVC : BaseTableViewController

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,copy)void(^sendZanYesOrNoBlock)(BOOL isZan,NSInteger number);
@end

NS_ASSUME_NONNULL_END
