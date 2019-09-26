//
//  QQYYReportAndCollectVIew.m
//  QIYU
//
//  Created by zk on 2019/9/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYReportAndCollectVIew.h"

static QQYYReportAndCollectVIew * danli = nil;

@implementation QQYYReportAndCollectVIew

- (UIView *)clearView {
    if (_clearView == nil) {
        _clearView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, ScreenH)];
        _clearView.backgroundColor =[UIColor colorWithWhite:1 alpha:0];
    }
    return _clearView;
}


- (UIButton *)cancelBt {
    if (_cancelBt == nil) {
        _cancelBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBt.frame = CGRectMake(0, ScreenH - 50 + 200, ScreenW, 50);
        _cancelBt.tag = 100;
        _cancelBt.titleLabel.font =[UIFont systemFontOfSize:18];
        [_cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelBt.backgroundColor = WhiteColor;
        
    }
    
    return _cancelBt;
}





+ (void)showWithArray:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath{
    
    [QQYYReportAndCollectVIew shareInstance].indexPath = indexPath;
    [[QQYYReportAndCollectVIew shareInstance].subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[QQYYReportAndCollectVIew shareInstance].clearView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[QQYYReportAndCollectVIew shareInstance] addSubview:[QQYYReportAndCollectVIew shareInstance].clearView];
    [QQYYReportAndCollectVIew shareInstance].clearView.hidden = NO;
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:[QQYYReportAndCollectVIew shareInstance]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[QQYYReportAndCollectVIew shareInstance] show];
    });
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:[QQYYReportAndCollectVIew shareInstance] action:@selector(removeV)];
    
    [[QQYYReportAndCollectVIew shareInstance] addGestureRecognizer:tap];
    for (int i = 0 ; i < arr.count ; i++) {
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, ScreenH - 50  - (i+1) * 50, ScreenW, 50);
        if (sstatusHeight > 20) {
            button.frame = CGRectMake(0, ScreenH - 50 - (i+1) * 50 - 34, ScreenW, 50);
        }
        [button setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        [button setTitle:arr[arr.count - 1 - i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [[QQYYReportAndCollectVIew shareInstance].clearView addSubview:button];
        button.tag = arr.count - 1 - i;
        [button addTarget:[QQYYReportAndCollectVIew shareInstance] action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * view  = [[UIView alloc] initWithFrame:CGRectMake(10, 49.4, ScreenW -20 , 0.6)];
        view.backgroundColor = lineBackColor;
        [button addSubview:view];

    }

    
    [[QQYYReportAndCollectVIew shareInstance].clearView addSubview:[QQYYReportAndCollectVIew shareInstance].cancelBt];
    [[QQYYReportAndCollectVIew shareInstance].cancelBt addTarget:[QQYYReportAndCollectVIew shareInstance] action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[QQYYReportAndCollectVIew shareInstance] addGestureRecognizer:tap];

}

- (void)removeV {
    [[QQYYReportAndCollectVIew shareInstance] diss];
    
}

+ (void)diss {
    
    [UIView animateWithDuration:0.25 animations:^{
        [QQYYReportAndCollectVIew shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [QQYYReportAndCollectVIew shareInstance].clearView.y = ScreenH;
        [QQYYReportAndCollectVIew shareInstance].cancelBt.y = ScreenH - 50 + 200;
        
    } completion:^(BOOL finished) {
        
        [[QQYYReportAndCollectVIew shareInstance] removeFromSuperview];
        
    }];
    
}

+ (QQYYReportAndCollectVIew *)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        danli = [[QQYYReportAndCollectVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        danli.backgroundColor =[UIColor colorWithWhite:0 alpha:0.1];
    });
    return danli;
}

- (void)clickAction:(UIButton *)button  {
    
    if (button.tag == 100) {
        
        [[QQYYReportAndCollectVIew shareInstance] diss];
    }else {
        [[QQYYReportAndCollectVIew shareInstance] diss];
        if ([QQYYReportAndCollectVIew shareInstance].delegate != nil && [self.delegate respondsToSelector:@selector(didSelectAtIndex:withIndexPath:)]) {
            [[QQYYReportAndCollectVIew shareInstance].delegate didSelectAtIndex:button.tag withIndexPath:self.indexPath];
        }
        
    }
    
    
}

- (void)show {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [QQYYReportAndCollectVIew shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [QQYYReportAndCollectVIew shareInstance].clearView.y = 0;
        [QQYYReportAndCollectVIew shareInstance].cancelBt.y = ScreenH - 50;
        if (sstatusHeight > 20) {
            [QQYYReportAndCollectVIew shareInstance].cancelBt.y = ScreenH - 50 - 34 ;
        }
    } completion:^(BOOL finished) {
        
        
    }];
    
}

- (void)diss {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [QQYYReportAndCollectVIew shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [QQYYReportAndCollectVIew shareInstance].clearView.y = ScreenH;
        [QQYYReportAndCollectVIew shareInstance].cancelBt.y = ScreenH - 50 + 200;
        
    } completion:^(BOOL finished) {
        
        [[QQYYReportAndCollectVIew shareInstance] removeFromSuperview];
        
    }];
    
    
}



@end
