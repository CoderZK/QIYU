//
//  QQYYDongTaiDetailCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QQYYDongTaiDetailCell;
@protocol QQYYDongTaiDetailCellDelegate <NSObject>
//0 头像 1 查看,2 评论 3 赞 ,4喜欢,5分享 6 点击查看原文
- (void)didClickButtonWithCell:(QQYYDongTaiDetailCell *)cell andIndex:(NSInteger )index;

@end

@interface QQYYDongTaiDetailCell : UITableViewCell
@property(nonatomic,strong)zkHomelModel *model;

@property(nonatomic,assign)id<QQYYDongTaiDetailCellDelegate> delegate;
@property(nonatomic,strong)UIView *lineV;

@property(nonatomic,assign)BOOL isDetail;
@property(nonatomic,strong)UIButton *cancelBt;

@end

NS_ASSUME_NONNULL_END
