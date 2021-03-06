//
//  QQYYRequestTool.h
//  QIYU
//
//  Created by zk on 2019/9/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void(^SuccessBlock)(NSURLSessionDataTask * task,id responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask * task,NSError * error);
NS_ASSUME_NONNULL_BEGIN

@interface QQYYRequestTool : NSObject
+(void)networkingPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;
+(NSURLSessionDataTask *)networkingGET:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 上传图片_json
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr image:(UIImage *)image andName:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;


/**
 多张上传图片
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images name:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;
/**
 多张上传图片和视频或者音频
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images imgName:(NSString *)name fileData:(NSData *)fileData andFileName:(NSString *)fileName parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

+ (void)uploadImagsWithArr:(NSArray *)arr withType:(NSString *)type result:(void(^)(NSString * str))resultBlock;
@end

NS_ASSUME_NONNULL_END
