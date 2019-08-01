//
//  QQYYMineOneCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QQYYMineOneCell;
@protocol QQYYMineOneCellDelegate <NSObject>

- (void)didClickHeadView:(QQYYMineOneCell *)cell withIndex:(NSInteger )index;

@end

@interface QQYYMineOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (weak, nonatomic) IBOutlet UIButton *ccopyBt;

@property(nonatomic,strong)QQYYUserModel *model;

@property (weak, nonatomic) IBOutlet UILabel *friendsLB;
@property (weak, nonatomic) IBOutlet UILabel *flowerLB;
@property (weak, nonatomic) IBOutlet UILabel *fansLB;
@property (weak, nonatomic) IBOutlet UILabel *subscribeLB;

@property(nonatomic,assign)id<QQYYMineOneCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
