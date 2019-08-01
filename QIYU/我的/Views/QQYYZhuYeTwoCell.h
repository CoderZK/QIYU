//
//  QQYYZhuYeTwoCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QQYYZhuYeTwoCell;

@protocol QQYYZhuYeTwoCellDelegate <NSObject>

- (void)didClickGuanZhuOrFansWith:(NSInteger )index;

@end

@interface QQYYZhuYeTwoCell : UITableViewCell
@property(nonatomic,strong)QQYYUserModel *model;
@property(nonatomic,assign)id<QQYYZhuYeTwoCellDelegate>delegate;
@property(nonatomic,strong)UIButton  *guanZhuBt;
@end

NS_ASSUME_NONNULL_END
