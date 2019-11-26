//
//  UIViewController+shareAction.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "UIViewController+shareAction.h"
#import <objc/runtime.h>
static const void *urlKey = &urlKey;
@implementation UIViewController (shareAction)

- (void)shareWithSetPreDefinePlatforms:(NSArray *)platforms withUrl:(NSString *)url shareModel:(zkHomelModel *)model{

    if (url == nil) {
        [QQYYRequestTool networkingPOST:[QQYYURLDefineTool shareURL] parameters:model.postId success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"code"] integerValue] == 0) {
                
                self.url = [NSString stringWithFormat:@"%@",responseObject[@"object"][@"data"]];;
                [UMSocialUIManager setPreDefinePlatforms:platforms];
                [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                    // 根据获取的platformType确定所选平台进行下一步操作
                    
                    NSString* thumbURL = @"";
                    if (model.pic.length > 0) {
                        thumbURL = [QQYYURLDefineTool getImgURLWithStr:[[model.pic componentsSeparatedByString:@","] firstObject]];
                    }
                    // @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
                    NSString * title = model.content;
                    if (model.content.length > 20) {
                        title = [model.content substringFromIndex:20];
                    }
                    if (thumbURL.length == 0) {
                         [self shareWebPageToPlatformType:platformType withTitle:title andContent:model.content thumImage:[UIImage imageNamed:@"logo"]];
                    }else {
                        [self shareWebPageToPlatformType:platformType withTitle:title andContent:model.content thumImage:thumbURL];
                    }
                   
                    
                }];
                
            }else {
                [SVProgressHUD showErrorWithStatus:@"获取分享信息失败"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"获取分享信息失败!"];
        }];
    }else {
        
        
        [UMSocialUIManager setPreDefinePlatforms:platforms];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            self.url = [QQYYSignleToolNew shareTool].downUrl;
            [self shareWebPageToPlatformType:platformType withTitle:@"花与蛇" andContent:[NSString stringWithFormat:@"注册邀请码:%@,欢迎下载注册使用",url] thumImage:[UIImage imageNamed:@"logo"]];
            
        }];
        
        
    }
    
    
    
}

- (void)setUrl:(NSString *)url {
    objc_setAssociatedObject(self, urlKey, url, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
    
- (NSString *)url {
    return objc_getAssociatedObject(self, urlKey);
}
    
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title andContent:(NSString *)contentStr thumImage:(id)thumImage
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:contentStr thumImage:thumImage];
    //设置网页地址
    shareObject.webpageUrl = self.url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}


- (NSDictionary *)getUseInfoWithToken:(NSString *)token {
    
//    [QQYYRequestTool networkingPOST:zkURL parameters:<#(id)#> success:<#^(NSURLSessionDataTask *task, id responseObject)success#> failure:<#^(NSURLSessionDataTask *task, NSError *error)failure#>]
    return @{};
}




@end
