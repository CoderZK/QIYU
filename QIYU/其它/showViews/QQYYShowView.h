//
//  QQYYShowView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QQYYShowView;
@protocol  QQYYShowViewdelegate<NSObject>

- (void)didClickIndex:(NSInteger )index;

@end

@interface QQYYShowView : UIView
@property(nonatomic,assign)NSInteger type; // 0 交友搜搜 1 消息时使用
- (void)showWithTitleArr:(NSArray *)titleArr andImgeStrArr:(NSArray *)imgeStrArr selectIndex:(NSInteger )index;
- (void)diss;
@property(nonatomic,assign)id<QQYYShowViewdelegate>delegate;
@end


@interface showBtView : UIView
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIImageView *imgVOne,*imgVTwo;
@property(nonatomic,strong)UILabel *titleLB;
- (void)showRed;
@end


NS_ASSUME_NONNULL_END
