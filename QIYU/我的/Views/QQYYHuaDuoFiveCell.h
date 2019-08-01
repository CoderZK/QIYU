//
//  QQYYHuaDuoFiveCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QQYYHuaDuoFiveCell;

@protocol QQYYHuaDuoFiveCellDelegate <NSObject>

- (void)didClickCell:(QQYYHuaDuoFiveCell *)cell index:(NSInteger )index;

@end


@interface QQYYHuaDuoFiveCell : UITableViewCell

@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@property(nonatomic,assign)id<QQYYHuaDuoFiveCellDelegate>delegate;

@end

@interface huoDuoBt : UIButton
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3,*LB4;
@property(nonatomic,strong)UIButton *gouBt;
@end


NS_ASSUME_NONNULL_END
