//
//  QQYYGongGaoThreeCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QQYYDetailZanCell;
@protocol QQYYGongGaoThreeCellegate <NSObject>

- (void)didClickGuanZhuBtWithIndex:(NSInteger)index;


@end


@interface QQYYGongGaoThreeCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,assign)id<QQYYGongGaoThreeCellegate>delegate;
@property(nonatomic,strong)NSString *numberStr;
@end

NS_ASSUME_NONNULL_END
