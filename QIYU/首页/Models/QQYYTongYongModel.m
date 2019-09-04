//
//  QQYYTongYongModel.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/13.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYTongYongModel.h"

@implementation QQYYTongYongModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id",@"AtMsg":@"newAtMsg",@"FriendMsg":@"newFriendMsg",@"LikeMsg":@"newLikeMsg",@"ReplyMsg":@"newReplyMsg",@"msgId":@"userMsgId",@"userContent":@"targetContent"};
}

- (void)setContent:(NSString *)content {
    _content = [NSString emojiRecovery:content];
}

- (void)setTargetContent:(NSString *)targetContent {
    _targetContent = [NSString emojiRecovery:targetContent];
}

- (void)setUserContent:(NSString *)userContent {
    _userContent = [NSString emojiRecovery:userContent];
}
- (void)setPostContent:(NSString *)postContent {
    _postContent = [NSString emojiRecovery:postContent];
}

- (void)setRemark:(NSString *)remark {
    _remark = [NSString emojiRecovery:remark];
}

- (void)setChatContent:(NSString *)chatContent {
    _chatContent = [NSString emojiRecovery:chatContent];
}

@end
