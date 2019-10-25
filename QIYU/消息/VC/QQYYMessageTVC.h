//
//  QQYYMessageTVC.h
//  QIYU
//
//  Created by zk on 2019/10/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYMessageTVC : BaseTableViewController
- (void)acquireDataFromServe;
@property(nonatomic,assign)NSInteger pageNo;
@end

NS_ASSUME_NONNULL_END
