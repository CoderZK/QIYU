//
//  QQYYHomeDongTaiCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkHomelModel.h"
NS_ASSUME_NONNULL_BEGIN

@class QQYYHomeDongTaiCell;
@protocol QQYYHomeDongTaiCellDelegate <NSObject>
//0 头像 1 查看,2 评论 3 赞 ,4喜欢,5分享 6 点击查看原文
- (void)didClickButtonWithCell:(QQYYHomeDongTaiCell *)cell andIndex:(NSInteger )index;
@end

@interface QQYYHomeDongTaiCell : UITableViewCell

@property(nonatomic,strong)UIButton *zanBt,*pingBt,*scanBt,*LikeBt,*shareBt,*sexBt,*biaoQianOneBt,*biaoQianTwoBt,*deleteBt;
@property(nonatomic,strong)zkHomelModel *model;

@property(nonatomic,assign)id<QQYYHomeDongTaiCellDelegate> delegate;
@property(nonatomic,strong)UIView *lineV;

@property(nonatomic,assign)BOOL isDetail;
@property(nonatomic,strong)UIButton *cancelBt;

@property(nonatomic,assign)BOOL isDelete;


@end

NS_ASSUME_NONNULL_END
