//
//  YJAddressTVC.h
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/12.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "BaseTableViewController.h"
#import "YJHomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YJAddressTVC : BaseTableViewController
/**  */
@property(nonatomic , copy)void(^sendAddressBlock)(YJHomeModel *model);
@end

NS_ASSUME_NONNULL_END
