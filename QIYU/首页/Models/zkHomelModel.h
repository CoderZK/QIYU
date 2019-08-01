//
//  zkHomelModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/24.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface zkHomelModel : NSObject
@property(nonatomic,strong)NSString *ID;// 圈子ID
@property(nonatomic,strong)NSString *circledId;// 圈子ID
@property(nonatomic,strong)NSString *content;//内容
@property(nonatomic,strong)NSString *postId; //帖子ID
@property(nonatomic,strong)NSString *age;//年龄
@property(nonatomic,strong)NSString *avatar;//头像
@property(nonatomic,strong)NSString *nickName;//用户昵称
@property(nonatomic,strong)NSString *createBy; //创建人ID
@property(nonatomic,strong)NSString *createTime;//创建时间
@property(nonatomic,strong)NSString *pic;//头像
@property(nonatomic,strong)NSString *tagName;//话题
@property(nonatomic,strong)NSString *provinceName; //省份
@property(nonatomic,strong)NSString *province;//省份
@property(nonatomic,strong)NSString *city;//省份
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *userNo;//环信ID 

@property(nonatomic,strong)NSString *distance;
@property(nonatomic,strong)NSString *userTags;//标签
@property(nonatomic,strong)NSString *tagsName;
@property(nonatomic,strong)NSString *tags;//标签
@property(nonatomic,strong)NSString *userId;//用户ID
@property(nonatomic,strong)NSString * huanxin;
@property(nonatomic,strong)NSString *outLineTime;

@property(nonatomic,assign)NSInteger heat;
@property(nonatomic,assign)NSInteger likeNum;
@property(nonatomic,assign)NSInteger replyNum;
@property(nonatomic,assign)NSInteger clickNum;
@property(nonatomic,assign)NSInteger gender;
@property(nonatomic,assign)NSInteger isOnline;


@property(nonatomic,assign)BOOL currentUserLike;//是否点赞
@property(nonatomic,assign)BOOL friends;
@property(nonatomic,assign)BOOL currentUserCollect;
@property(nonatomic,assign)BOOL isVip;
@property(nonatomic,assign)BOOL inMyBlackList;//是否是黑名单


@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)BOOL isZhanKai;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)BOOL subscribed;

@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *replyInfoVoList;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *postLikeVoList;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *fansList;
//评论内部的资料
@property(nonatomic,strong)NSString *blogUserAvatar;
@property(nonatomic,strong)NSString *blogUserId;
@property(nonatomic,strong)NSString *blogUserNickName;
@property(nonatomic,strong)NSString *replyId;
@property(nonatomic,strong)NSString *replyUserId;
@property(nonatomic,strong)NSString *replyUserNickName; //省份
@property(nonatomic,strong)NSString *targetContent;//省份
@property(nonatomic,strong)NSString *replyUserAvatar;

@property(nonatomic,strong)NSString *fansNum;
@property(nonatomic,strong)NSString *profile; //简介
@property(nonatomic,strong)NSString *announcement;//
@property(nonatomic,strong)NSString *sign;//

@property(nonatomic,strong)NSString *createAvatar;
@property(nonatomic,strong)NSString *createNickName; //简介


@property(nonatomic,strong)NSString *chatContent;
@property(nonatomic,strong)NSString *lastChatTime;
@property(nonatomic,strong)NSString *friendNickName;
@property(nonatomic,strong)NSString *friendHuanXin;
@property(nonatomic,strong)NSString *friendId;
@property(nonatomic,strong)NSString *circleName;



@end




//@interface zkPLNModel : NSObject
//
//
//
//@end


