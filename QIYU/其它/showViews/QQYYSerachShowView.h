//
//  QQYYSerachShowView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QQYYSerachShowView;
@protocol QQYYSerachShowViewDelegate <NSObject>
- (void)didIsClickConfrimBt:(BOOL)isConfirm withType:(NSInteger )type andSelectArr:(NSArray *)selectArr andSelectNameArr:(NSArray *)nameArr proviceId:(NSString *)proviceId proviceName:(NSString *)proviceName;
@end


@interface QQYYSerachShowView : UIView
@property(nonatomic,strong)NSMutableArray *dataArray; //数据
@property(nonatomic,strong)NSArray *sexSelectArr,*biaoQianSelectArr,*citySelectArr,*marrSelectArr;
@property(nonatomic,assign)NSInteger type;//展示的类型
@property(nonatomic,strong)NSString *proviceID,*proviceName;
- (void)show;//展示
- (void)diss;//消失
@property(nonatomic,assign)id<QQYYSerachShowViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
