//
//  QQYYHomeThreeCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYHomeThreeCell : UITableViewCell
@property(nonatomic,strong)UIButton *desBt;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,copy)void (^clickIndexBlock)(NSInteger index);
@property(nonatomic,strong)NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
