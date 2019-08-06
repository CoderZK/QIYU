//
//  QQYYLoginVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYLoginVC : BaseViewController
@property(nonatomic,assign)NSInteger loginType;
@property(nonatomic,strong)NSString *phoneStr,*passwordStr;
@end

NS_ASSUME_NONNULL_END
