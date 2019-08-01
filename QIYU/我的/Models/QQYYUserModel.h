//
//  QQYYUserModel.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class zkHomelModel;

@interface QQYYUserModel : NSObject
@property (nonatomic , strong) NSString * weight; //体重
@property (nonatomic , strong) NSString * userNo; //环信
@property (nonatomic , strong) NSString * userId; 
@property (nonatomic , strong) NSString * nickName;
@property (nonatomic , assign) NSString  *tags; //标签ID
@property (nonatomic , strong) NSString  *tagsName; //标签
@property (nonatomic , strong) NSString * nickname;
@property (nonatomic , strong) NSString * age;
@property (nonatomic , strong) NSString * authStatus;
@property (nonatomic , strong) NSString * avatar; //头像
@property (nonatomic , strong) NSString * birthday;
@property (nonatomic , strong) NSString * photos;
@property (nonatomic , strong) NSString * phone;
@property (nonatomic , strong) NSString  *huanxin_id;
@property (nonatomic , strong) NSString  *height;
@property (nonatomic , strong) NSString  *distance;
@property (nonatomic , strong) NSString * provinceName;
@property (nonatomic , strong) NSString * city;
@property (nonatomic , strong) NSString * cityName;
@property (nonatomic , strong) NSString * provinceId;
@property (nonatomic , strong) NSString * sexualOrientation;
@property (nonatomic , strong) NSString  *sign;
@property (nonatomic , strong) NSString  *marriageStatusStr;
@property(nonatomic,strong)NSString *background;

@property(nonatomic,strong)NSArray<zkHomelModel *> *postInfoVoList;

@property(nonatomic,assign)BOOL isVip;
@property(nonatomic,assign)BOOL currentUserIsVip;
@property(nonatomic,assign)BOOL friends; // 是否是朋友
@property(nonatomic,assign)BOOL subscribed;//是否关注
@property(nonatomic,assign)BOOL inMyBlackList;//是否是黑名单

@property (nonatomic , assign) NSInteger  fansNum;
@property (nonatomic , assign) NSInteger  flowerNum;
@property (nonatomic , assign) NSInteger  friendNum;
@property (nonatomic , assign) NSInteger  subscribeNum;
@property (nonatomic , assign) NSInteger  marriageStatus;
@property (nonatomic , assign) NSInteger  gender;
@property (nonatomic , assign) NSInteger  sexGo;


@property (nonatomic , assign) NSInteger  fans_num;
@property (nonatomic , assign) NSInteger  xx;
@property (nonatomic , assign) NSInteger  xxx;
@property (nonatomic , assign) NSInteger  xxxx;

@property(nonatomic,assign)CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
