//
//  zkSignleTool.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSignleTool.h"
#import "zkRequestTool.h"
static zkSignleTool * tool = nil;


@implementation zkSignleTool

+ (zkSignleTool *)shareTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[zkSignleTool alloc] init];
    });
    return tool;
}

-(void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

-(void)setSession_token:(NSString *)session_token
{
    
    [[NSUserDefaults standardUserDefaults] setObject:session_token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)session_token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}
-(void)setSession_uid:(NSString *)session_uid
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",session_uid] forKey:@"id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)session_uid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
}

-(void)setHuanxin:(NSString *)huanxin
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",huanxin] forKey:@"huanxin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)huanxin
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"huanxin"];
}

-(void)setNickName:(NSString *)nickName
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",nickName] forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)nickName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
}


-(void)uploadDeviceToken
{
    if (self.isLogin&&self.session_token&&self.deviceToken)
    {
        NSDictionary * dic = @{
                               @"token":self.session_token,
                               @"type":@1,
                               @"deviceToken":self.deviceToken
                               };
//        [zkRequestTool networkingPOST:[zkFMURL GETapi_user_upTokenURL] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            NSLog(@"上传友盟推送成功\n%@",responseObject);
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//        }];
    }
    
}






- (void)setLatitude:(double)latitude {
    [[NSUserDefaults standardUserDefaults] setDouble:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (double)latitude {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:@"latitude"];
}

- (void)setLongitude:(double)longitude {
    [[NSUserDefaults standardUserDefaults] setDouble:longitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (double)longitude {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:@"longitude"];
}

- (void)setDeviceToken:(NSString *)deviceToken {
    
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (NSString *)deviceToken {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] == nil) {
        return @"1";
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    
}

- (void)setImg:(NSString *)img {
    
    [[NSUserDefaults standardUserDefaults] setObject:img forKey:@"img"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (NSString *)img {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"img"];
    
}



- (void)setUserModel:(QQYYUserModel *)userModel{



    if (userModel) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
        if (data) {
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userModel"];
        }
    }
}
- (QQYYUserModel *)userModel{
    //取出

    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"];

    if (data) {
        QQYYUserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return model;
    }
    return nil;

}


@end
