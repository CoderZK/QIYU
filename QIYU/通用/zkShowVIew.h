//
//  zkShowVIew.h
//  FangZhiAPP
//
//  Created by kunzhang on 2019/6/19.
//  Copyright © 2019年 张坤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol zkShowVIewDelegate <NSObject>

- (void)didClickIndex:(NSInteger)index;

- (void)didSelctStr:(NSString *)str idStr:(NSString *)idStr;


@end

@interface zkShowVIew : UIView

/**  */
@property(nonatomic , assign)id<zkShowVIewDelegate>deleate;

- (void)show;
- (void)diss;
/**  */
@property(nonatomic , assign)BOOL isShow;

@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
