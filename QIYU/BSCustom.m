//
//  BSCustom.m
//  BBB
//
//  Created by ZK on 15/5/23.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "BSCustom.h"
#import "AppDelegate.h"
#import "QQYYPostMessageTVC.h"
#import "TabBarController.h"
@interface BSCustom()

@end

@implementation BSCustom

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"alpha"]];
        [self setShadowImage:[UIImage imageNamed:@"alpha"]];
        self.translucent = NO;
        //给一个tabbar加阴影
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        //阴影偏移
        self.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        //阴影透明度
        self.layer.shadowOpacity = 0.5;
        //阴影半径
        self.layer.shadowRadius = 5;
        
        
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"qy35"] forState:(UIControlStateNormal)];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"qy35"] forState:(UIControlStateSelected)];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        [self.publishButton addTarget:self action:@selector(pushView) forControlEvents:UIControlEventTouchUpInside];
        
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbarImage.png"]];
//        // [UITabBar appearance].clipsToBounds = YES; // 添加的图片大小不匹配的话，加上此句，屏蔽掉tabbar多余部分
//        [self setShadowImage:[UIImage imageNamed:@"tabbarImage.png"]];
        
//        CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        UIGraphicsBeginImageContext(rect.size);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//        CGContextFillRect(context, rect);
//        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//
//        [self setBackgroundImage:img];
//        // [UITabBar appearance].clipsToBounds = YES; // 添加的图片大小不匹配的话，加上此句，屏蔽掉tabbar多余部分
//        [self setShadowImage:img];
        
        
        
    }
   
    return self;
}

- (void)pushView {//弹出中间发布页面

    TabBarController *vc1 = (TabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    BaseNavigationController * vc2 = (BaseNavigationController *)vc1.selectedViewController;
    BaseViewController * vc3 = [vc2.childViewControllers firstObject];
    if (![QQYYSignleToolNew shareTool].isLogin) {
        [vc3 gotoLoginVC];
        
    }else {
        QQYYPostMessageTVC * vc =[[QQYYPostMessageTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [vc2 pushViewController:vc animated:YES];
    }
    
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
   
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5 , 49 * 0.5 - 10);
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = 49;
    NSUInteger index = 0;
    
    
    //图文上下排布
    self.publishButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [self.publishButton setTitleEdgeInsets:UIEdgeInsetsMake(60 ,-self.publishButton.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self.publishButton setImageEdgeInsets:UIEdgeInsetsMake(-60.0, 0.0,0.0, -self.publishButton.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    
    for (UIView * button  in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;

            CGFloat buttonX = buttonW * ((index > 1 ) ? (index + 1) : index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++ ;
        
    }
    
}



@end
