//
//  QQYYSearchHeadView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QQYYSearchHeadView;

@protocol QQYYSearchHeadViewDelegate <NSObject>

- (void)didClickIndex:(NSInteger )index withIsShow:(BOOL)isShow;

@end
@interface QQYYSearchHeadView : UIView
@property(nonatomic,assign)id<QQYYSearchHeadViewDelegate>delegate;
- (void)cancel;
@end

NS_ASSUME_NONNULL_END
