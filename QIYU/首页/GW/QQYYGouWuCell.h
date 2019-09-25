//
//  QQYYGouWuCell.h
//  QIYU
//
//  Created by zk on 2019/9/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QQYYGouWuCell;;
@protocol QQYYGouWuCheCellDelegate <NSObject>

- (void)didIndex:(NSInteger)index withCell:(QQYYGouWuCell *)cell;

@end



@interface QQYYGouWuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *leftMoneyLB;
@property (weak, nonatomic) IBOutlet UILabel *rightMoneyLB;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;

@property(nonatomic,assign)id<QQYYGouWuCheCellDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
