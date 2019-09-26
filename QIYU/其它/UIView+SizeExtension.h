//
//  UIView+SizeExtension.h
//  QIYU
//
//  Created by zk on 2019/9/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SizeExtension)
@property (nonatomic , assign)CGFloat width;
@property (nonatomic , assign)CGFloat height;
@property (nonatomic , assign)CGFloat x;
@property (nonatomic , assign)CGFloat y;
@property (nonatomic , assign)CGSize size;
@property (nonatomic , assign)CGFloat centerX;
@property (nonatomic , assign)CGFloat centerY;
@end

NS_ASSUME_NONNULL_END
