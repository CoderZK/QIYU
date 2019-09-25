//
//  BaseViewController.h
//  kunzhang_learnkunzhang海食汇
//
//  Created by kunzhang on 16/10/13.
//  Copyright © 2016年 cznuowang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController
@property(strong,nonatomic)UIButton * clickBt2;
- (void)gotoLoginVC;

/**
 *  导航条左侧按钮的赋值/点击
 *
 *  @param imgName   导航条图片
 *  @param title     导航条标题
 *  @param leftBtn   左侧按钮
 *  @param buttonClick 点击bloc
 */

-(void)setNavLeftBtnWithImg:(NSString *)imgName title:(NSString *)title withBlock:(void (^)(UIButton *leftBtn))leftBtn handleBtn:(void(^)())buttonClick;

/**
 *  导航条右侧按钮的赋值/点击
 *  @param imgName   导航条图片
 *  @param title     导航条标题
 *  @param clickBt   右侧按钮
 *  @param buttonClick 点击bloc
 */
- (void)setNavclickBtWithImg:(NSString *)imgName title:(NSString *)title withBlock:(void (^)(UIButton *clickBt))clickBt handleBtn:(void(^)())buttonClick;

- (BOOL)isCanUsePhotos;
- (BOOL)isCanUsePicture;



@end

