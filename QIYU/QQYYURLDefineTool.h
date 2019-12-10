//
//  QQYYURLDefineTool.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


////测试本地
#define URLOne @"http://www.flowersnake.com"
////图片地址
#define ImgURL @"http://www.flowersnake.com/upload"

////测试本地映射
//#define URLOne @"http://efi7fb.natappfree.cc"
////图片映射
//#define ImgURL @"http://efi7fb.natappfree.cc:80/upload"



@interface QQYYURLDefineTool : NSObject

/** 登录 */
+ (NSString * )getLoginURL;
/** 退出登录 */
+ (NSString * )getlogoutURL;
/** 广告列表 */
+ (NSString * )getBannerListURL;
/** 标签列表 */
+ (NSString * )getLabelsURL;
/** 话题列表 */
+ (NSString * )getTopicListURL;
/** 登录 */
+ (NSString * )getloginAuthByThirdURL;
/**省列表*/
+ (NSString * )provinceListURL;
/**市列表*/
+ (NSString * )cityListURL;
/** 注册 */
+ (NSString * )registerURL;
/** 发送验证码 */
+ (NSString * )sendValidCodeURL;
/** 街道列表 */
+ (NSString * )streetListURL;
/** 上传文件 */
+ (NSString * )uploadURL;
/** 用户主页 */
+ (NSString * )gethomeURL;
/** 广告列表 */
+ (NSString * )getsetMyLabelURL;
/** 发帖*/
+ (NSString * )getaddURL;
/** 帖子详情 */
+ (NSString * )getdetailURL;
/** 社交圈子 */
+ (NSString * )getSysSocialCircleListURL;
/** 点赞 */
+ (NSString * )getlikeURL;
/** 评论帖子*/
+ (NSString * )getreplyURL;
/** 帖子列表 */
+ (NSString * )getsearchURL;
/** 校验验证码 */
+(NSString *)validCodeURL;
/** 上包地理位置 */
+(NSString *)reportLocationURL;
/** 送花 */
+(NSString *)sendFlowers;

/** 获取隐私设置*/
+ (NSString * )getUserConfigURL;
/** 热度榜 */
+ (NSString * )heatUserListURL;
/** 附近的人 */
+ (NSString * )nearbyUserListURL;
/** 修改头像和背景图片 */
+ (NSString * )updateAvatarURL;
/** 换帮手机号*/
+ (NSString * )updatePhoneURL;
/** 修改密码 */
+ (NSString * )updatePwdURL;
/** 换绑第三方*/
+(NSString *)updateThirdAppURL;
/** 隐私设置更新*/
+(NSString *)updateUserConfigURL;
/** 关于我们 */
+(NSString *)aboutUsURL;
/** 我收到的赞列表*/
+ (NSString * )getPostLikeListForMyPostURL;
/** 我收到的评论列表 */
+ (NSString * )getReplyListForMyPostURL;
/** 我的粉丝列表 */
+ (NSString * )getMyFansUserListURL;
/** 我的详细资料 */
+ (NSString * )getMyInfoURL;
/** 我的个人中心*/
+ (NSString * )getMyInfoCenterURL;
/** 我的订阅 */
+ (NSString * )getMySubscribeUserListURL;
/** 修改我的个人资料*/
+(NSString *)updateMyInfoURL;
/**  用户上传相册 */
+(NSString *)uploadPhotoURL;
/** 提交反馈*/
+(NSString *)addMyFeedBackURL;
/** 添加好友*/
+(NSString *)addNewFriendURL;
/** 同意或者绝好友*/
+(NSString *)agreeNewFriendApplyURL;
/** 我的动态点赞列表*/
+(NSString *)getMyPostLikeListURL;
/** 删除拉黑好友*/
+(NSString *)deleteFriendURL;

/** 我的反馈列表*/
+(NSString *)getMyFeedBackListURL;
/** 好友列表*/
+(NSString *)getMyFriendUserListURL;
/** 我的访客列表*/
+(NSString *)getMyVisitorListURL;
/** 根据id查找新朋友*/
+(NSString *)getNewFriendByUserNoURL;
/** 实名认证*/
+(NSString *)userAuthURL;
/**拉黑好友 我的动态点赞列表*/
+(NSString *)addUserFriendBlackURL;
/** 恢复好友*/
+(NSString *)deleteUserFriendBlackURL;
/** 我的任务中心*/
+(NSString *)getMyTaskListURL;
/** 我的黑名单*/
+(NSString *)getMyUserFriendBlackListURL;
/** 获取我的消息*/
+(NSString *)getMyMessageListURL;


/** 提交提现申请*/
+(NSString *)addWithDrawURL;
/** cancelOrder*/
+(NSString *)cancelOrderURL;
/** closeOrder*/
+(NSString *)closeOrderURL;
/** 我的订单列表*/
+(NSString *)getMyOrderListURL;
/** 订单支付*/
+(NSString *)orderPayURL;
/**订单退款*/
+(NSString *)refundOrderURL;
/** 恢复好友*/
+(NSString *)addMyCollectionURL;
/** 添加我的收藏*/
+(NSString *)deleteMyCollectionURL;
/** 删除我的收藏*/
+(NSString *)getMyCollectionListURL;
/** 我的消费记录*/
+(NSString *)getMyConsumeOrderListURL;
/** 我的充值记录*/
+(NSString *)getMyReChargeOrderListURL;
/** 我的提现列表*/
+(NSString *)getMyWithDrawListURL;

/** 新朋友列表*/
+(NSString *)getNewFriendMsgListURL;

/** 帖子评论列表*/
+(NSString *)getReplyPageListForPostURL;
/**@我的消息*/
+(NSString *)getAtMeMsgListURL;

/** 我的动态评论列表*/
+(NSString *)deleteMegURL;

/** 关注 */
+(NSString *)addUserSubscribeURL;
/** 取消订阅*/
+(NSString *)deleteUserSubscribeURL;
/** 取消订阅*/
+(NSString *)getSysSocialCircleDetailURL;

/**爱豆套餐*/
+(NSString *)getHeatPkgListURL;
/** vip 套餐*/
+(NSString *)getVipPkgListURL;
/** 我的动态评论列表*/
+(NSString *)uploadUserChatRecordURL;
/** vip 订单提交*/
+(NSString *)vipReChargeURL;
/** 爱豆交易记录 */
+(NSString *)getMyFlowerOrderListURL;
/** 爱豆充值*/
+(NSString *)heatReChargeURL;
/** 我的动态评论列表*/
+(NSString *)addMyReportURL;
/** 添加银行卡*/
+(NSString *)addMyBankCardURL;
/** 银行卡列表*/
+(NSString *)getMyBankCardListURL;
/** 删除银行卡*/
+(NSString *)deleteMyBankCardURL;
/** 取消点赞*/
+(NSString *)notlikeURL;

/** 删除回话*/
+(NSString *)deleteUserChatHoldURL;
/** 我的系统消息列表 */
+(NSString *)getMySysMsgListURL;
/** 获取客服*/
+(NSString *)contactKefURL;
/** 银行卡列表*/
+(NSString *)deletePostURL;
/** 绑定手机和第三方*/
+(NSString *)bindPhoneAndAppKeyURL;
/** 支付*/
+(NSString *)cccOrderURL;

/** 分享*/
+(NSString *)shareURL;
    /** 更新*/
+(NSString *)getIosConfigURL;

    /** 领取奖励*/
+(NSString *)getMyTaskRewardURL;
    /** 上传推送token*/
+(NSString *)GETapi_user_upTokenURL;


+(NSString *)getImgURLWithStr:(NSString * )str;








@end

NS_ASSUME_NONNULL_END
