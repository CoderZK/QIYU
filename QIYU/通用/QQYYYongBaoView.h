//
//  QQYYYongBaoView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QQYYYongBaoView;
@protocol QQYYYongBaoViewDeletage <NSObject>

- (void)didClcikIndex:(NSInteger)index withIndexPath:(NSIndexPath *)indexPath WithNumber:(NSString * )str;

@end

@interface QQYYYongBaoView : UIView
- (void)showWithIndexPath:(NSIndexPath *)indexPath;
- (void)diss;
@property(nonatomic,assign)id<QQYYYongBaoViewDeletage>deletage;
@end

NS_ASSUME_NONNULL_END
