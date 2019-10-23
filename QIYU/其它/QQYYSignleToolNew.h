//
//  QQYYSignleToolNew.h
//  QIYU
//
//  Created by zk on 2019/9/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "QQYYUserModel.h"
@interface QQYYSignleToolNew : NSObject

+ (QQYYSignleToolNew *)shareTool;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,strong)NSString * session_token;
@property(nonatomic,strong)NSString * nickName;
@property(nonatomic,strong)NSString * img;
@property(nonatomic,strong)NSString * huanxin;
@property(nonatomic)double  latitude;
@property(nonatomic)double  longitude;
@property(nonatomic,assign)BOOL isppp;
@property(nonatomic,strong)NSString * session_uid;
@property(nonatomic,strong)NSString * deviceToken;
@property(nonatomic,strong)QQYYUserModel *userModel;
@property(nonatomic,strong)NSString * downUrl;

-(void)uploadDeviceToken;
@end

