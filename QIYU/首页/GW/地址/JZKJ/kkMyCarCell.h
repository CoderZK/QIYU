//
//  kkMyCarCell.h
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/19.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface kkMyCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btW;

@end

NS_ASSUME_NONNULL_END
