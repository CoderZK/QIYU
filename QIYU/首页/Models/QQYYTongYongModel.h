//
//  QQYYTongYongModel.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/13.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYTongYongModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *useAble;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *createByUserPic;//用户头像
@property(nonatomic,strong)NSString *createByNickName;//用户昵称
@property(nonatomic,strong)NSString *createDate; //创建时间
@property(nonatomic,strong)NSArray *imgList;//图片
@property(nonatomic,strong)NSString *replyCount;//回复数量
@property(nonatomic,strong)NSString *supportCount; //点赞数量
@property(nonatomic,strong)NSString *supportNickNames;//点赞人
@property(nonatomic,strong)NSString *supportUserIds;//点赞人
@property(nonatomic,assign)BOOL isSelect;

@property(nonatomic,strong)NSString * AtMsg;
@property(nonatomic,strong)NSString * FriendMsg;
@property(nonatomic,strong)NSString * LikeMsg;
@property(nonatomic,strong)NSString * ReplyMsg;


@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *createBy;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *postContent;
@property(nonatomic,strong)NSString *postId;
@property(nonatomic,strong)NSString *msgId;
@property(nonatomic,strong)NSString *friendAvatar;

@property(nonatomic,strong)NSString *blogUserAvatar;
@property(nonatomic,strong)NSString *blogUserId;
@property(nonatomic,strong)NSString *blogUserNickName;
@property(nonatomic,strong)NSString *replyId;
@property(nonatomic,strong)NSString *replyUserId;
@property(nonatomic,strong)NSString *replyUserNickName; //省份
@property(nonatomic,strong)NSString *targetContent;//省份
@property(nonatomic,strong)NSString *replyUserAvatar;
@property(nonatomic,strong)NSString *userContent;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *createByAvatar;
@property(nonatomic,strong)NSString *remark;

@property(nonatomic,strong)NSString *description;
@property(nonatomic,strong)NSString *reward;
@property(nonatomic,strong)NSString *userTaskId;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *orderFee;
@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSString *outLineTime;
@property(nonatomic,strong)NSString *chatContent;
@property(nonatomic,strong)NSString *lastChatTime;
@property(nonatomic,strong)NSString *friendNickName;
@property(nonatomic,strong)NSString *friendHuanXin;
@property(nonatomic,strong)NSString *friendId;
@property(nonatomic,strong)NSString *userId;//用户ID
@property(nonatomic,strong)NSString *heat;
@property(nonatomic,strong)NSString *heatGift;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *orderType;//2爱豆套餐3爱豆提现4任务奖励5爱豆打赏支出6爱豆打赏收入
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *flowerNum;

@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)NSString *cardNo;
@property(nonatomic,strong)NSString *bankCardId;
@property(nonatomic,strong)NSString *userChatHoldId;


@property(nonatomic,assign)NSInteger unreadMessagesCount;//未读消息数量
@property(nonatomic,assign)NSInteger status; //状态1申请中2通过3拒绝

@end

NS_ASSUME_NONNULL_END
