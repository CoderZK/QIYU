//
//  QQYYQuanZiGuiZeListTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface QQYYQuanZiGuiZeListTVC : BaseTableViewController
@property(nonatomic,assign)BOOL isFaTie;
@property(nonatomic,copy)void(^typeBlock)(NSString *ID , NSString * name);
@end

NS_ASSUME_NONNULL_END
