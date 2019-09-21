//
//  zkSignleTool.h
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQYYUserModel.h"
@interface zkSignleTool : NSObject

+ (zkSignleTool *)shareTool;
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

-(void)uploadDeviceToken;
@end
