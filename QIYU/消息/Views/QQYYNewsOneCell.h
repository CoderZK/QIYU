//
//  QQYYNewsOneCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYNewsOneCell : UITableViewCell
@property(nonatomic,copy)void(^clickIndexBlock)(NSInteger index);
@property(nonatomic,strong)QQYYTongYongModel *model;
@end

NS_ASSUME_NONNULL_END
