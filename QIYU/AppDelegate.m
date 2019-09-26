//
//  AppDelegate.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessage.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UserNotifications/UserNotifications.h>
#import <WXApi.h>
#import "TabBarController.h"
#import "LYGuideViewController.h"
#import <JKRBDMuteSwitch/RBDMuteSwitch.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "QQYYMovieVC.h"

#define UMKey @"5d43d8d13fc195f5a2000497"
//友盟安全密钥//r6xbw5gy0zenei6x56xtm9wmkrrz653y
#define SinaAppKey @"2593734403"
#define SinaAppSecret @"f021858321817f3b0e3bdb570fb87401"
#define WXAppID @"wx0e4284e5ce1faacf"
#define WXAppSecret @"0a977030a1b23d21ce2478015aefb202"
#define QQAppID @"101755968"
#define QQAppKey @"c735a72f6f30331957a435c6ad80980a"


@interface AppDelegate ()<EMChatManagerDelegate,RBDMuteSwitchDelegate,UNUserNotificationCenterDelegate,WXApiDelegate>
@property(nonatomic,assign)BOOL isJingYin;
@property(nonatomic,assign)CGFloat yinLiang;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController =   [self instantiateRootVC];
//    self.window.rootViewController = [[QQYYMovieVC alloc] init];
    [self.window makeKeyAndVisible];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];

    [self setConfigUMSharePlatforms];
    [self initUment:launchOptions];

    // 发送崩溃日志
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
    if (data != nil) {
        
//        [self sendExceptionLogWithData:data path:dataPath];
        
    }
    if ([YWUnlockView haveGesturePassword]) {
        [self privacyPassWord];
    }
    
    EMOptions *options = [EMOptions optionsWithAppkey:huanXinAppKey];
    // apnsCertName是证书名称，可以先传nil，等后期配置apns推送时在传入证书名称
    options.apnsCertName = nil;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //上包位置
    [QQYYpublicFunction updateLatitudeAndLongitude];
    
    [[EMClient sharedClient].chatManager addDelegate:self  delegateQueue:nil];;
    
//    //是否静音
    [[RBDMuteSwitch sharedInstance] setDelegate:self];
    [[RBDMuteSwitch sharedInstance] detectMuteSwitch];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    self.yinLiang = audioSession.outputVolume;
    
    [MPVolumeView new];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemVolumeDidChangeNoti:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    

    [QQYYSignleToolNew shareTool].isppp = NO;
    
    return YES;
}

-(void)systemVolumeDidChangeNoti:(NSNotification* )noti{//目前手机音量
    float voiceSize = [[noti.userInfo valueForKey:@"AVSystemController_AudioVolumeNotificationParameter"]floatValue];
    NSLog(@"\n===========----%lf",voiceSize);
    self.yinLiang = voiceSize;
    
}


//收到环信消息时发送通知去刷新通知和校信的信息
- (void)messagesDidReceive:(NSArray *)aMessages {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    CGFloat currentVol = audioSession.outputVolume;
    
    NSLog(@"\n----%lf",currentVol);

    if (self.yinLiang == 0) {
         AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }else {
        AudioServicesPlaySystemSound(1012);
    }
    
    
    UITabBarController * tabvc = self.window.rootViewController;
    if (tabvc.selectedIndex == 2) {
        BaseNavigationController * navc = tabvc.childViewControllers[2];
        if ([[navc.childViewControllers lastObject] isKindOfClass:[HangQingVC class]]) {
            HangQingVC * vc = (HangQingVC *)[navc.childViewControllers lastObject];
            vc.pageNo = 1;
            [vc acquireDataFromServe];
        }
    }
    
    
        //
        ////
        //     AudioServicesPlaySystemSound(1007);
        //    return;
    
    
}



- (void)privacyPassWord {
    
    YWUnlockView * v = [YWUnlockView shareInstace];
    v.type = YWUnlockViewUnlock;
    __weak typeof(self) weakSelf = self;
    v.block = ^(BOOL result) {
        NSLog(@"-->%@",@(result));
        
        
        
    };
    v.forgetPassBlock = ^(NSInteger type) {
        NSLog(@"-->%@",@(type));
        
        if(type == 1) {
           
            
            [self OutUserLoginAction];
            
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    
}

//退出登录
- (void)OutUserLoginAction {
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool getlogoutURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {

            [QQYYSignleToolNew shareTool].isLogin = NO;
            TabBarController * tavc = (TabBarController *)self.window.rootViewController;
            tavc.selectedIndex = 0;
            [[EMClient sharedClient] logout:YES];
            [YWUnlockView deleteGesturesPassword];

        }else {
           
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
}

- (void)setConfigUMSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:QQAppKey redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

- (void)initUment:(NSDictionary *)launchOptions{
    //友盟适配https
    [UMessage startWithAppkey:UMKey launchOptions:launchOptions httpsEnable:YES];
    [UMessage registerForRemoteNotifications];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
}




//在用户接受推送通知后系统会调用
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
//    self.pushToken = deviceToken;
//    if (![LxmTool ShareTool].isClosePush)
//    {
//        [UMessage registerDeviceToken:deviceToken];
//        //2.获取到deviceToken
//        NSString *token = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
//        //将deviceToken给后台
//        NSLog(@"send_token:%@",token);
//        [LxmTool ShareTool].deviceToken = token;
//        //[[LxmTool ShareTool] uploadDeviceToken];
//    }
//    else
//    {
//        [UMessage registerDeviceToken:nil];
//        [LxmTool ShareTool].deviceToken = @"";
//        //[[LxmTool ShareTool] uploadDeviceToken];
//    }
    
    
}


//设置根视图控制器
- (UIViewController *)instantiateRootVC{
    //没有引导页
    TabBarController *BarVC=[[TabBarController alloc] init];
    return BarVC;
//    //获取app运行的版本号
//    NSString *currentVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
//    //取出本地缓存的版本号
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *localVersion = [defaults objectForKey:@"appversion"];
//    if ([currentVersion isEqualToString:localVersion]) {
//        TabBarController *BarVC=[[TabBarController alloc] init];
//        return BarVC;
//        //        TabBarController * tabVc = [[TabBarController alloc] init];
//        //        return tabVc;
//
//    }else{
//        LYGuideViewController *guideVc = [[LYGuideViewController alloc] init];
//        return guideVc;
//    }
}
//跳转主页
- (void)showHomeVC{
    TabBarController  *BarVC=[[TabBarController alloc] init];
    self.window.rootViewController = BarVC;
    
    //更新本地储存的版本号
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"appversion"];
    //同步到物理文件存储
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -支付宝 微信支付
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wx013aad9217dedd99://pay"] ) {
        //微信
        [WXApi handleOpenURL:url delegate:self];
    }else {//友盟
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    return YES;
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知,告诉支付界面要做什么
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wx013aad9217dedd99://pay"] ) {
        [WXApi handleOpenURL:url delegate:self];
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wx013aad9217dedd99://pay"] ) {
        [WXApi handleOpenURL:url delegate:self];
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    }
    return YES;
}
//微信支付结果
- (void)onResp:(BaseResp *)resp {
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPAY" object:resp];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
