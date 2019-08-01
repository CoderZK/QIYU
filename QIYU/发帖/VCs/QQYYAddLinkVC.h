//
//  QQYYAddLinkVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYAddLinkVC : BaseViewController
@property(nonatomic,copy)void(^linkBlock)(NSString * linkStr);
@end

NS_ASSUME_NONNULL_END
