//
//  zkJuBaoView.h
//  miaoZai
//
//  Created by kunzhang on 2017/5/10.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zkJuBaoViewDelegate <NSObject>

//弹出的的时候点击的第几行
- (void)didSelectAtIndex:(NSInteger )index withIndexPath:(NSIndexPath *)indexPath;





@end

@interface zkJuBaoView : UIView
+(zkJuBaoView *)shareInstance;

//在当前界面点击分享
+ (void)didSlectShar;


+ (void)showWithArray:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath;



+ (void)diss;

/*dialing*/
@property (nonatomic , assign)id<zkJuBaoViewDelegate> delegate;

@end
