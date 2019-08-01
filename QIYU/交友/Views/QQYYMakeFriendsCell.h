//
//  QQYYMakeFriendsCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYMakeFriendsCell : UITableViewCell
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UILabel *contentLB,*timeLB,*addressLB;
@property(nonatomic,strong)UILabel *typeLB;
@property(nonatomic,strong)zkHomelModel *model;
@property(nonatomic,assign)BOOL isHot;
@end

NS_ASSUME_NONNULL_END
