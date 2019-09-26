//
//  QQYYReportAndCollectVIew.h
//  QIYU
//
//  Created by zk on 2019/9/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol QQYYReportAndCollectVIewDelegate <NSObject>
//弹出的的时候点击的第几行
- (void)didSelectAtIndex:(NSInteger )index withIndexPath:(NSIndexPath *)indexPath;
@end
@interface QQYYReportAndCollectVIew : UIView
+(QQYYReportAndCollectVIew *)shareInstance;
+ (void)didSlectShar;
+ (void)showWithArray:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath;
+ (void)diss;
@property (nonatomic , assign)id<QQYYReportAndCollectVIewDelegate> delegate;
@property (nonatomic , strong)UIView * clearView;
@property (nonatomic , strong)UIButton * cancelBt;
@property(nonatomic,strong)NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
