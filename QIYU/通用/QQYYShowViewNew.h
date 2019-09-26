//
//  QQYYShowViewNew.h
//  QIYU
//
//  Created by zk on 2019/9/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQYYShowViewNewDelegate <NSObject>

- (void)didClickIndex:(NSInteger)index;

- (void)didSelctStr:(NSString *)str idStr:(NSString *)idStr;


@end
@interface QQYYShowViewNew : UIView
@property(nonatomic , assign)id<QQYYShowViewNewDelegate>deleate;
- (void)show;
- (void)diss;
@property(nonatomic , assign)BOOL isShow;
@property(nonatomic , strong)UIView *HeiSeBlackViewNew;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@end


