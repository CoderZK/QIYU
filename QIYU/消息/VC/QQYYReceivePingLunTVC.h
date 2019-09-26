//
//  QQYYReceivePingLunTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

@interface QQYYReceivePingLunTVC : BaseTableViewController
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@end

