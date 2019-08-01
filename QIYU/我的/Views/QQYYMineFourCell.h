//
//  QQYYMineFourCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QQYYMineFourCell;
@protocol QQYYMineFourCellDelegate <NSObject>

- (void)didClickView:(QQYYMineFourCell *)cell withIndex:(NSInteger )index;

@end

@interface QQYYMineFourCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *friendsLB;
@property (weak, nonatomic) IBOutlet UILabel *flowerLB;
@property (weak, nonatomic) IBOutlet UILabel *fansLB;
@property (weak, nonatomic) IBOutlet UILabel *subscribeLB;

@property(nonatomic,assign)id<QQYYMineFourCellDelegate>delegate;
@property(nonatomic,strong)QQYYUserModel *model;
@end

NS_ASSUME_NONNULL_END
