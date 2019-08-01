//
//  QQYYPhotoCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QQYYPhotoCell;
@protocol QQYYPhotoCellDelegate <NSObject>

- (void)didClickView:(QQYYPhotoCell *)cell isDelect:(BOOL)isDelect andIsAdd:(BOOL)isAdd withIndex:(NSInteger )index;

@end


@interface QQYYPhotoCell : UITableViewCell

@property(nonatomic,assign)BOOL isDelect;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)id<QQYYPhotoCellDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
