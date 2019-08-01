//
//  UIViewController+NewWorkTwo.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NewWorkTwo)
//删除消息
- (void)deleteMessageWithMessageId:(NSString *)ID result:(void(^)(BOOL isOK))deleteBlock;
//送花
- (void)sendFlowerWithNumber:(NSString *)number andLinkId:(NSString *)ID andIsGiveUser:(BOOL)isGeiUser result:(void(^)(BOOL isOK))resultBlock;

- (void)gotoCharWithOtherHuanXinID:(NSString *)huanxin andOtherUserId:(NSString *)userId andOtherNickName:(NSString *)nickName andOtherImg:(NSString *)img andVC:(BaseViewController *)baseVc;

@end

NS_ASSUME_NONNULL_END
