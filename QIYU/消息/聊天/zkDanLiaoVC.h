//
//  zkDanLiaoVC.h
//  weekend
//
//  Created by kunzhang on 17/1/22.
//  Copyright © 2017年 李炎. All rights reserved.
//

#import <EaseUI/EaseUI.h>

@interface zkDanLiaoVC : EaseMessageViewController

- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;

/** 头像 */
@property(nonatomic , copy)NSString * otherHeadImg;
/** 头像 */
@property(nonatomic , copy)NSString * otherName;
/** 他人的ID */
@property(nonatomic , copy)NSString *otherId;
/** 别人环信id */
@property(nonatomic , copy)NSString * otherHuanXinId;



/** 自己的头像 */
@property(nonatomic , copy)NSString * myHeadImg;
/** 自己的 */
@property(nonatomic , copy)NSString * myName;
/** 字的环信id */
@property(nonatomic , copy)NSString * myHuanXinId;


@end
