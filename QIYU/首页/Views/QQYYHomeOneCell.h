//
//  QQYYHomeOneCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^clcikBlock)(NSInteger index);

@interface QQYYHomeOneCell : UITableViewCell
@property(nonatomic,copy)void(^clickIndexBlock)(NSInteger index);

@property(nonatomic,copy)clcikBlock indexBlock;

@end

@interface btView : UIView
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *bt;
@property(nonatomic,strong)UIButton *numberBt;
@end


NS_ASSUME_NONNULL_END
