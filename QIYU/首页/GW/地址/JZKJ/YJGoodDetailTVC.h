//
//  YJGoodDetailTVC.h
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/13.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "BaseTableViewController.h"
#import "YJHomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YJGoodDetailTVC : BaseTableViewController
@property(nonatomic,strong)YJHomeModel *model;
/**  */
@property(nonatomic , assign)NSInteger  index;
@end

NS_ASSUME_NONNULL_END
