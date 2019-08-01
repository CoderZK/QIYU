//
//  QQYYNewsTwoCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYNewsTwoCell : UITableViewCell
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UIButton  *bageBt;//系那是红点用
@property(nonatomic,assign)NSInteger type; // 0 消息首页用  1 新朋友用
@property(nonatomic,strong)UIButton *typeBt,*cancelBt;
@property(nonatomic,strong)UILabel *contentLB,*timeLB,*nameLB;
@property(nonatomic,strong)QQYYTongYongModel *model;

@end

NS_ASSUME_NONNULL_END
