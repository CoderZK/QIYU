//
//  zkHomelModel.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/24.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkHomelModel.h"

@implementation zkHomelModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)setReplyInfoVoList:(NSMutableArray<zkHomelModel *> *)replyInfoVoList {
    _replyInfoVoList = [zkHomelModel mj_objectArrayWithKeyValuesArray:replyInfoVoList];
}

- (void)setPostLikeVoList:(NSMutableArray<zkHomelModel *> *)postLikeVoList {
    _postLikeVoList = [zkHomelModel mj_objectArrayWithKeyValuesArray:postLikeVoList];
    
}

- (void)setFansList:(NSMutableArray<zkHomelModel *> *)fansList {
    _fansList = [zkHomelModel mj_objectArrayWithKeyValuesArray:fansList];
}

- (void)setContent:(NSString *)content {
    _content = [NSString emojiRecovery:content];
}

- (void)setTargetContent:(NSString *)targetContent {
    _targetContent = [NSString emojiRecovery:targetContent];
}

- (void)setChatContent:(NSString *)chatContent {
    _chatContent = [NSString emojiRecovery:chatContent];
}

@end





