//
//  QQYYQunSettingTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQYYQunSettingTVC : BaseTableViewController
@property(nonatomic,strong)RACSubject *delegateSignl;
@end

NS_ASSUME_NONNULL_END


@interface QQYYQunHeadView : UIView
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *headBt;
@end
