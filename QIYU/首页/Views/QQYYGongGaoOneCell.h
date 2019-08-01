//
//  QQYYGongGaoOneCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QQYYGongGaoOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *guanZhuBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wwcon;

@end

NS_ASSUME_NONNULL_END
