//
//  QQYYShowPickerView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYShowPickerView : UIView
- (void)showWithDataArr:(NSArray *)arr;

@property(nonatomic,copy)void(^didSelectIndexBlock)(NSInteger index);

@property(nonatomic,copy)void(^didSelectCityBlock)(NSString *cityName,NSString *cityId ,NSString *provinceName,NSString *provinceID);

@property(nonatomic,assign)BOOL isAddress;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *provityArr;

@end

NS_ASSUME_NONNULL_END
