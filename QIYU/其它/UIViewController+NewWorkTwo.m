//
//  UIViewController+NewWorkTwo.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "UIViewController+NewWorkTwo.h"



@implementation UIViewController (NewWorkTwo)

- (void)deleteMessageWithMessageId:(NSString *)ID result:(void(^)(BOOL isOK))deleteBlock{

    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool deleteMegURL] parameters:ID success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 0) {
            deleteBlock(YES);
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
    
    
}

- (void)gotoCharWithOtherHuanXinID:(NSString *)huanxin andOtherUserId:(NSString *)userId andOtherNickName:(NSString *)nickName andOtherImg:(NSString *)img andVC:(BaseViewController *)baseVc{
    
    if ([userId isEqualToString:[QQYYSignleToolNew shareTool].session_uid]) {
        [SVProgressHUD showErrorWithStatus:@"自己不能喝自己聊天"];
        return;
    }
    
    zkDanLiaoVC * vc = [[zkDanLiaoVC alloc] initWithConversationChatter:huanxin conversationType: EMConversationTypeChat];
    vc.otherId = userId;
    vc.otherName = nickName;
    vc.otherHuanXinId = huanxin;
    vc.otherHeadImg = [QQYYURLDefineTool getImgURLWithStr:img];
    vc.myName = [QQYYSignleToolNew shareTool].nickName;
    vc.myHeadImg = [QQYYSignleToolNew shareTool].img;
    vc.myHuanXinId = [QQYYSignleToolNew shareTool].huanxin;
    vc.hidesBottomBarWhenPushed = YES;
    [baseVc.navigationController pushViewController:vc animated:YES];
    
}


- (void)sendFlowerWithNumber:(NSString *)number andLinkId:(NSString *)ID andIsGiveUser:(BOOL)isGeiUser result:(void(^)(BOOL isOK))resultBlock {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"flowerNum"] = @([number integerValue]);
    requestDict[@"linkId"] = ID;
    if (isGeiUser) {
        requestDict[@"type"] = @"userInfo";
    }else {
        requestDict[@"type"] = @"postInfo";
    }
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool sendFlowers] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 0) {
            
            resultBlock(YES);
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
    
    
}


@end
