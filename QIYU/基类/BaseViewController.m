//
//  BaseViewController.m
//  kunzhang
//
//  Created by kunzhang on 16/10/13.
//  Copyright © 2016年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"
//#import "LogionTVC.h"
typedef void (^Nav)(UIButton *);
typedef void (^Nav2)();

@interface BaseViewController ()
@property (nonatomic, copy)Nav2 leftBlock2;
@property (nonatomic, copy)Nav2 rightBlock2;
@end
@implementation BaseViewController

- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleCustom)];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setMaximumDismissTimeInterval:2.0];
    
    self.view.backgroundColor= BackgroundColor;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem=backItem;
}


//左侧导航条按钮点击
-(void)setNavLeftBtnWithImg:(NSString *)imgName title:(NSString *)title withBlock:(void (^)(UIButton *leftBtn))leftBtn handleBtn:(void (^)())butnClick{
    
    UIButton *leftBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn2.frame = CGRectMake(- 20 , 0 , 44 , 44 );
    if (imgName!=nil&&imgName.length>0&&title!=nil&&title.length>0) {
        leftBtn2.frame = CGRectMake(-20, 0, 110, 44);
        leftBtn2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    imgName = imgName==nil||[imgName isEqual:[NSNull null]]?@"返回":imgName;
    title = title==nil||[title isEqual:[NSNull null]]?@"":title;
    leftBtn2.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [leftBtn2 addTarget : self action : @selector (tapLeftBtn) forControlEvents : UIControlEventTouchUpInside ];//设置按钮点击事件
    [leftBtn2 setTitle:[NSString stringWithFormat:@"%@",title] forState:UIControlStateNormal];
    [leftBtn2 setImage :[UIImage imageNamed:imgName] forState : UIControlStateNormal]; //设置按钮正常状态图片
    [leftBtn2 setImage :[UIImage imageNamed:imgName] forState : UIControlStateSelected ];//设置按钮选中图片
    //    //NSLog(@"+++++++%@",leftBtn2.titleLabel.text);
    UIBarButtonItem *leftBarButon2 = [[ UIBarButtonItem alloc ] initWithCustomView :leftBtn2];
    if (([[[ UIDevice currentDevice ] systemVersion ] floatValue ]>= 7.0 ? 20 : 0 ))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc ]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target : nil
                                           action : nil ];
        negativeSpacer. width = - 20 ;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[ negativeSpacer, leftBarButon2 ] ;
       
    } else{
        self.navigationItem.leftBarButtonItem = leftBarButon2;
    }
    
    if (leftBtn) {
        leftBtn(leftBtn2);
    }
    
    self.leftBlock2 = butnClick;
}

//右侧点击按钮
-(void)setNavclickBtWithImg:(NSString *)imgName title:(NSString *)title withBlock:(void (^)(UIButton *newClickUpAndInsideBT))newClickUpAndInsideBT handleBtn:(void (^)())butnClick{
    _clickBt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickBt2.frame = CGRectMake(-20 , 0 , 60 , 44 );
    if (imgName!=nil&&imgName.length>0&&title!=nil&&title.length>0) {
        _clickBt2.frame = CGRectMake(-20, 0, 110, 44);
        _clickBt2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    title = title==nil||[title isEqual:[NSNull null]]?@"":title;
    [_clickBt2 addTarget : self action : @selector (tapclickBt) forControlEvents : UIControlEventTouchUpInside ];//设置按钮点击事件
    [_clickBt2 setTitle:title forState:UIControlStateNormal];
    _clickBt2.titleLabel.font = [UIFont systemFontOfSize:14];
    [_clickBt2 setImage :[UIImage imageNamed:imgName] forState : UIControlStateNormal]; //设置按钮正常状态图片
    [_clickBt2 setImage :[UIImage imageNamed:imgName] forState : UIControlStateSelected ];//设置按钮选中图片
    UIBarButtonItem *rightBarButon2 = [[ UIBarButtonItem alloc ] initWithCustomView:_clickBt2];
    if (([[[ UIDevice currentDevice ] systemVersion ] floatValue ]>= 7.0 ? 20 : 0 ))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc ]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target : nil
                                           action : nil ];
        negativeSpacer. width = - 5 ;//这个数值可以根据情况自由变化
        self.navigationItem.rightBarButtonItems = @[ negativeSpacer, rightBarButon2 ] ;
        
    } else{
        self.navigationItem.leftBarButtonItem = rightBarButon2;
    }
    
    newClickUpAndInsideBT(_clickBt2);
    
    self.rightBlock2 = butnClick;
}


- (BOOL)isCanUsePhotos {
    
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        return NO;
    }
    return YES;
}
- (BOOL)isCanUsePicture{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}




- (void)gotoLoginVC {
    
    QQYYLoginVC * vc =[[QQYYLoginVC alloc] init];
    BaseNavigationController * navc =[[BaseNavigationController alloc] initWithRootViewController:vc];;
    [self presentViewController:navc animated:YES completion:nil];
    
    
}

//- (void)updateNewAppWith:(NSString *)strOfAppid {
//    [SVProgressHUD show];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",strOfAppid]];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request
//                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                                         [SVProgressHUD dismiss];
//                                         if (data)
//                                         {
//                                             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                                             
//                                             if (dic)
//                                             {
//                                                 NSArray * arr = [dic objectForKey:@"results"];
//                                                 if (arr.count>0)
//                                                 {
//                                                     NSDictionary * versionDict = arr.firstObject;
//                                                     
//                                                     NSString * version = [[versionDict objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
//                                                     
//                                                     if ([[QQYYSignleToolNew shareTool].version intValue] >= [version intValue]) {
//                                                         return ;
//                                                     }
//                                                     
//                                                     NSString * currentVersion = [[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];
//                                                     
//                                                     if ([version integerValue]>[currentVersion integerValue])
//                                                     {
//                                                         
//                                                         
//                                                         UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                                                         
//                                                         [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                                                             
//                                                             [QQYYSignleToolNew shareTool].version = version;
//                                                             
//                                                         }]];
//                                                         [alert addAction:[UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                                             
//                                                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",strOfAppid]]];
//                                                             exit(0);
//                                                             
//                                                         }]];
//                                                         [self presentViewController:alert animated:YES completion:nil];
//                                                     }else {
//                                                         [SVProgressHUD showSuccessWithStatus:@"目前安装的已是最新版本"];
//                                                     }
//                                                     
//                                                     
//                                                 }
//                                             }
//                                         }
//                                     }] resume];
//    
//    
//}


@end
