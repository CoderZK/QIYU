//
//  QQYYURLDefineTool.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYURLDefineTool.h"

@implementation QQYYURLDefineTool

/** 登录 */
+ (NSString * )getLoginURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/login"];
}
/** 广告列表 */
+ (NSString * )getBannerListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/getBannerList"];
}
/** 标签列表 */
+ (NSString * )getLabelsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/getLabels"];
}
/** 话题列表 */
+ (NSString * )getTopicListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/getTopicList"];
}
/** 第三方登录 */
+ (NSString * )getloginAuthByThirdURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/loginAuthByThird"];
}
/**省列表*/
+ (NSString * )provinceListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/provinceList"];
}
/**市列表*/
+ (NSString * )cityListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/cityList"];
}
/** 注册 */
+ (NSString * )registerURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/register"];
}
/** 发送验证码 */
+ (NSString * )sendValidCodeURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/sendValidCode"];
}
/** 街道列表 */
+ (NSString * )streetListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/streetList"];
}
/** 上传文件 */
+ (NSString * )uploadURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/upload"];
}
/** 用户主页 */
+ (NSString * )gethomeURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/home"];
}
/** 设置标签 */
+ (NSString * )getsetMyLabelURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/setMyLabel"];
}
/** 发帖*/
+ (NSString * )getaddURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/add"];
}
/** 帖子详情 */
+ (NSString * )getdetailURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/detail"];
}
/** 社交圈子 */
+ (NSString * )getSysSocialCircleListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/getSysSocialCircleList"];
}
/** 点赞 */
+ (NSString * )getlikeURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/like"];
}
/** 评论帖子*/
+ (NSString * )getreplyURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/reply"];
}
/** 帖子列表 */
+ (NSString * )getsearchURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/search"];
}
/** 校验验证码 */
+(NSString *)validCodeURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/validCode"];
}
/** 上包地理位置 */
+(NSString *)reportLocationURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/reportLocation"];
}
/** 送花 */
+(NSString *)sendFlowers{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/sendFlowers"];
}
/** 获取隐私设置*/
+ (NSString * )getUserConfigURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getUserConfig"];
}
/** 热度榜 */
+ (NSString * )heatUserListURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/heatUserList"];
}
/** 附近的人 */
+ (NSString * )nearbyUserListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/nearbyUserList"];
}
/** 修改头像和背景图片 */
+ (NSString * )updateAvatarURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/updateAvatar"];
}
/** 换帮手机号*/
+ (NSString * )updatePhoneURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/updatePhone"];
}
/** 修改密码 */
+ (NSString * )updatePwdURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/updatePwd"];
}
/** 换绑第三方*/
+(NSString *)updateThirdAppURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/updateThirdApp"];
}
/** 隐私设置更新*/
+(NSString *)updateUserConfigURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/updateUserConfig"];
}
/** 关于我们 */
+(NSString *)aboutUsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/aboutUs"];
}
/** 退出登录 */
+ (NSString * )getlogoutURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/logout"];
}

/** 我收到的赞列表*/
+ (NSString * )getPostLikeListForMyPostURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getPostLikeListForMyPost"];
}
/** 我收到的评论列表 */
+ (NSString * )getReplyListForMyPostURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getReplyListForMyPost"];
}
/** 我的粉丝列表 */
+ (NSString * )getMyFansUserListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyFansUserList"];
}
/** 我的详细资料 */
+ (NSString * )getMyInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyInfo"];
}
/** 我的个人中心*/
+ (NSString * )getMyInfoCenterURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyInfoCenter"];
}
/** 我的订阅 */
+ (NSString * )getMySubscribeUserListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMySubscribeUserList"];
}
/** 修改我的个人资料*/
+(NSString *)updateMyInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/updateMyInfo"];
}
/**  用户上传相册 */
+(NSString *)uploadPhotoURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/uploadPhoto"];
}
/** 提交反馈*/
+(NSString *)addMyFeedBackURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/addMyFeedBack"];
}
/** 添加好友*/
+(NSString *)addNewFriendURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/addNewFriend"];
}
/** 同意或者绝好友*/
+(NSString *)agreeNewFriendApplyURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/agreeNewFriendApply"];
}

/** 删除拉黑好友*/
+(NSString *)deleteFriendURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/deleteFriend"];
}

/** 我的反馈列表*/
+(NSString *)getMyFeedBackListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyFeedBackList"];
}
/** 好友列表*/
+(NSString *)getMyFriendUserListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyFriendUserList"];
}
/** 我的访客列表*/
+(NSString *)getMyVisitorListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyVisitorList"];
}
/** 根据id查找新朋友*/
+(NSString *)getNewFriendByUserNoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getNewFriendByUserNo"];
}
/** 实名认证*/
+(NSString *)userAuthURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/userAuth"];
}
/**拉黑好友 我的动态点赞列表*/
+(NSString *)addUserFriendBlackURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/addUserFriendBlack"];
}
/** 恢复好友*/
+(NSString *)deleteUserFriendBlackURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/deleteUserFriendBlack"];
}
/** 我的任务中心*/
+(NSString *)getMyTaskListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyTaskList"];
}
/** 我的黑名单*/
+(NSString *)getMyUserFriendBlackListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyUserFriendBlackList"];
}
/** 获取我的消息*/
+(NSString *)getMyMessageListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyMessageList"];
}

/** 提交提现申请*/
+(NSString *)addWithDrawURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/addWithDraw"];
}
/** cancelOrder*/
+(NSString *)cancelOrderURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/cancelOrder"];
}
/** closeOrder*/
+(NSString *)closeOrderURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/closeOrder"];
}
/** 我的订单列表*/
+(NSString *)getMyOrderListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/getMyOrderList"];
}
/** 订单支付*/
+(NSString *)orderPayURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/orderPay"];
}
/**订单退款*/
+(NSString *)refundOrderURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/refundOrder"];
}
/** 添加收藏*/
+(NSString *)addMyCollectionURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/addMyCollection"];
}
/**  删除我的收藏*/
+(NSString *)deleteMyCollectionURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/deleteMyCollection"];
}
/** 添加我的收藏 */
+(NSString *)getMyCollectionListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyCollectionList"];
}
/** 我的消费记录*/
+(NSString *)getMyConsumeOrderListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyConsumeOrderList"];
}
/** 我的充值记录*/
+(NSString *)getMyReChargeOrderListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyReChargeOrderList"];
}
/** 我的提现列表*/
+(NSString *)getMyWithDrawListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyWithDrawList"];
}
/** 新朋友列表*/
+(NSString *)getNewFriendMsgListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getNewFriendMsgList"];
}
/** 帖子评论列表*/
+(NSString *)getReplyPageListForPostURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/getReplyPageListForPost"];
}

/**@我的消息*/
+(NSString *)getAtMeMsgListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getAtMeMsgList"];
}
///** 我的动态评论列表*/
+(NSString *)deleteMegURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/deleteMsg"];
}
/** 关注 */
+(NSString *)addUserSubscribeURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/addUserSubscribe"];
}
/** 取消订阅*/
+(NSString *)deleteUserSubscribeURL{
  return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/deleteUserSubscribe"];
}
/** 取消订阅*/
+(NSString *)getSysSocialCircleDetailURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/getSysSocialCircleDetail"];
}
/**爱豆套餐*/
+(NSString *)getHeatPkgListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/getHeatPkgList"];
}
/** vip 套餐*/
+(NSString *)getVipPkgListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/getVipPkgList"];
}
/** 上传最后一条信息*/
+(NSString *)uploadUserChatRecordURL{
    
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userChat/uploadUserChatRecord"];
    
}
/** vip 订单提交*/
+(NSString *)vipReChargeURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/vipReCharge"];
}

/** 爱豆交易记录 */
+(NSString *)getMyFlowerOrderListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyFlowerOrderList"];
}

/** 爱豆充值*/
+(NSString *)heatReChargeURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/order/heatReCharge"];
}

/** 我的动态评论列表*/
+(NSString *)addMyReportURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/addMyReport"];
}
/** 添加银行卡*/
+(NSString *)addMyBankCardURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/addMyBankCard"];
}
/** 银行卡列表*/
+(NSString *)getMyBankCardListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMyBankCardList"];
}
/** 删除银行卡*/
+(NSString *)deleteMyBankCardURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/deleteMyBankCard"];
}
/** 取消点赞*/
+(NSString *)notlikeURL{
    
     return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/notlike"];
    
}

/** 删除回话*/
+(NSString *)deleteUserChatHoldURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userChat/deleteUserChatHold"];
    
}
/** 我的系统消息列表 */
+(NSString *)getMySysMsgListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/userInfo/getMySysMsgList"];
}

/** 获取客服*/
+(NSString *)contactKefURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/contactKef"];
}
/** 删除帖子*/
+(NSString *)deletePostURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/delete"];
}

/** 绑定手机和第三方*/
+(NSString *)bindPhoneAndAppKeyURL{
    
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/common/bindPhoneAndAppKey"];
}
/** 分享*/
+(NSString *)shareURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"/api/postInfo/share"];
}




//图片地址
+(NSString *)getImgURLWithStr:(NSString * )str{
    
    NSString * picStr = @"";
    if (str) {
        if ([str hasPrefix:@"http:"] || [str hasPrefix:@"https:"]) {
            picStr = str;
        }else{
            picStr = [NSString stringWithFormat:@"%@%@",ImgURL,str];
        }
    }
    return picStr;

}




@end
