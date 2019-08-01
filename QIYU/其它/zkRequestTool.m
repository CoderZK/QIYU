//
//  zkRequestTool.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkRequestTool.h"

@implementation zkRequestTool

//+(void)networkingPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
//{
//
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy.validatesDomainName = NO;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript",@"text/x-chdr", nil];
//
//    if ([zkSignleTool shareTool].session_token != nil) {
//
//        NSLog(@"\ntoken ==== %@",[zkSignleTool shareTool].session_token);
//
//
//        if ([zkSignleTool shareTool].isLogin) {
//            [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[zkSignleTool shareTool].session_token] forHTTPHeaderField:@"Authorization"];
//        }else {
//            [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
//        }
//    }else {
//        [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
//    }
//
////    manager.requestSerializer = [AFJSONRequestSerializer serializer];
////    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if (success)
//        {
//            success(task,responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        [SVProgressHUD showErrorWithStatus:@"请求异常!"];
//        if (failure)
//        {
//            failure(task,error);
//        }
//    }];
//
//}


+(void)networkingPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSLog(@"===\n%d",[parameters isKindOfClass:[NSString class]]);

    
    NSString * jsonStr = @"";
    if ([parameters isKindOfClass:[NSString class]]) {
        jsonStr = parameters;
    }else {
        jsonStr = [NSString convertToJsonDataWithDict:parameters];
    }
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:nil error:nil];
    if ([zkSignleTool shareTool].session_token != nil) {
        
        NSLog(@"===\n%@",[zkSignleTool shareTool].session_token);

        
        if ([zkSignleTool shareTool].isLogin) {
            req.allHTTPHeaderFields = @{@"Authorization":[NSString stringWithFormat:@"Bearer %@",[zkSignleTool shareTool].session_token]};
        }else {
            req.allHTTPHeaderFields = @{@"Authorization":@"Bearer "};
        }
    }else {
        req.allHTTPHeaderFields = @{@"Authorization":@"Bearer "};
    }
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            success(nil,responseObject);
        } else {
            failure(nil,error);
            [SVProgressHUD showErrorWithStatus:@"网络异常!!!!"];
        }
        
    }] resume];

}


+(void)networkingJsonPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString * jsonStr = [NSString convertToJsonDataWithDict:parameters];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:nil error:nil];
    if ([zkSignleTool shareTool].session_token != nil) {
        if ([zkSignleTool shareTool].isLogin) {
            req.allHTTPHeaderFields = @{@"Authorization":[NSString stringWithFormat:@"Bearer %@",[zkSignleTool shareTool].session_token]};
        }else {
            req.allHTTPHeaderFields = @{@"Authorization":@"Bearer "};
        }
    }else {
        req.allHTTPHeaderFields = @{@"Authorization":@"Bearer "};
    }
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            success(nil,responseObject);
        } else {
            failure(nil,error);
            [SVProgressHUD showErrorWithStatus:@"网络异常!!!!"];
        }
        
    }] resume];
    
    //    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    //        if (!error) {
    //            success(nil,responseObject);
    //        } else {
    //            failure(nil,error);
    //            [SVProgressHUD showErrorWithStatus:@"网络异常!!!!"];
    //        }
    //    }] resume];
    
    
}

+(NSURLSessionDataTask *)networkingGET:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    if ([zkSignleTool shareTool].session_token != nil) {
        if ([zkSignleTool shareTool].isLogin) {
            [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[zkSignleTool shareTool].session_token] forHTTPHeaderField:@"Authorization"];
        }else {
            [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
        }
    }else {
        [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
    }
    NSURLSessionDataTask * task =  [manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [SVProgressHUD showErrorWithStatus:@"请求异常!"];
        if (failure)
        {
            failure(task,error);
        }
    }];
 
    return task;
}
/**
 上传图片
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr image:(UIImage *)image andName:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [mDict setValue:device forKey:@"deviceId"];
//    [mDict setValue:@1 forKey:@"channel"];
//    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [mDict setValue:version forKey:@"version"];
//    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
//    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    NSDictionary * dict = parameters;
    //获取josnzi字符串
//    NSString * josnStr = [NSString convertToJsonData:dict];
//    //获取MD5字符串
//    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    if ([zkSignleTool shareTool].isLogin) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[zkSignleTool shareTool].session_token] forHTTPHeaderField:@"Authorization"];
    }else {
        [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
    }
    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (image) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:name  fileName:@"195926458462659.png" mimeType:@"image/jpeg"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求异常!"];
        if (failure)
        {
            failure(task,error);
        }
    }];
}
/**
 多张上传图片
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images name:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    NSDictionary * dict = parameters;
    //    //获取josnzi字符串
    //    NSString * josnStr = [NSString convertToJsonData:dict];
    //    //获取MD5字符串
    //    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
    //    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UIImage * image in images)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:name fileName:@"teswwt1.jpg" mimeType:@"image/jpeg"];
            
        }
        
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求异常!"];
        if (failure)
        {
            failure(task,error);
        }
    }];
}

/**
 上传视频或者视频
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images imgName:(NSString *)name fileData:(NSData *)fileData andFileName:(NSString *)fileName parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [mDict setValue:device forKey:@"deviceId"];
//    [mDict setValue:@1 forKey:@"channel"];
//    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [mDict setValue:version forKey:@"version"];
//    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    
    
//    NSDictionary * dict = parameters;
//    //获取josnzi字符串
//    NSString * josnStr = [NSString convertToJsonData:dict];
//    //获取MD5字符串
//    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    NSString * str = [NSString convertToJsonDataWithDict:mDict];
    
    [manager POST:urlStr parameters:str constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UIImage * image in images)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:name fileName:@"teswwt1.jpg" mimeType:@"image/jpeg"];
            
        }
        if (fileData) {
            [formData appendPartWithFileData:fileData name:fileName fileName:@"369369.mp4" mimeType:@"video/quicktime"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求异常!"];
        if (failure)
        {
            failure(task,error);
        }
    }];
}


+ (void)uploadImagsWithArr:(NSArray *)arr withType:(NSString *)type result:(void(^)(NSString * str))resultBlock{
    
    [zkRequestTool NetWorkingUpLoad:[QQYYURLDefineTool uploadURL] images:arr name:@"files" parameters:@{@"type":type} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"] intValue] == 0) {
            
            if (resultBlock) {
                resultBlock(responseObject[@"object"][@"data"]);
            }
        }else {
            if (resultBlock) {
                resultBlock(@"0");
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (resultBlock) {
            resultBlock(@"0");
        }
    }];
    
}




@end
