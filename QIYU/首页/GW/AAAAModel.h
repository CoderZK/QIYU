//
//  AAAAModel.h
//  QIYU
//
//  Created by zk on 2019/10/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAAAModel : NSObject
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * des;
@property(nonatomic,strong)NSString *desTwo;
@property(nonatomic,strong)NSString *imgStr;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)CGFloat price;

@end

NS_ASSUME_NONNULL_END
