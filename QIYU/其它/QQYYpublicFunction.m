//
//  QQYYpublicFunction.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYpublicFunction.h"
#import <CoreLocation/CoreLocation.h>

static QQYYpublicFunction * hhyP = nil;

@interface QQYYpublicFunction()<CLLocationManagerDelegate>
{
    
    CLLocationManager*locationmanager;//定位服务
    
    NSString*strlatitude;//经度
    
    NSString*strlongitude;//纬度
    
}
@end

@implementation QQYYpublicFunction

+ (QQYYpublicFunction *)sharTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hhyP = [[QQYYpublicFunction alloc] init];
    });
    return hhyP;
    
}

+ (CAShapeLayer *)getBezierWithFrome:(UIView * )view andRadi:(CGFloat)radi {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(radi, radi)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
    
}

+ (void)updateLatitudeAndLongitude {
    
    [[QQYYpublicFunction sharTool] starAction];
}

- (void)starAction {
    
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
    
}

#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    [self updateLatitudeAndLongtude:currentLocation.coordinate.latitude andLongitude:currentLocation.coordinate.longitude];
    [QQYYSignleToolNew shareTool].latitude = currentLocation.coordinate.latitude;
    [QQYYSignleToolNew shareTool].longitude = currentLocation.coordinate.longitude;
    
    //反地理编码
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
//     {
//         NSLog(@"反地理编码");
//         NSLog(@"反地理编码%ld",placemarks.count);
//         if (placemarks.count > 0) {
//             CLPlacemark *placeMark = placemarks[0];
//             /*看需求定义一个全局变量来接收赋值*/
//             NSLog(@"城市----%@",placeMark.country);//当前国家
//             NSLog(@"城市%@",self.label_city.text);//当前的城市
//             NSLog(@"%@",placeMark.subLocality);//当前的位置
//             NSLog(@"%@",placeMark.thoroughfare);//当前街道
//             NSLog(@"%@",placeMark.name);//具体地址
//             
//         }
//     }];
    
}


- (void)updateLatitudeAndLongtude:(CGFloat)latitude andLongitude:(CGFloat)longitude{
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"latitude"]  = @(latitude);
    requestDict[@"longitude"] = @(longitude);
    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool reportLocationURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]== 0) {
            
            
            
        }else {
           
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
  
        
    }];
    
}

@end
