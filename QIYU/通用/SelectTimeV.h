//
//  SelectTimeV.h
//  动画
//
//  Created by kunzhang on 17/10/19.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTimeV : UIView
@property (nonatomic, copy) void (^block)(NSString *);

@property (nonatomic ,assign)BOOL isBaoHanHHmm;

@property (nonatomic ,assign)BOOL isCanSelectOld;

@end
