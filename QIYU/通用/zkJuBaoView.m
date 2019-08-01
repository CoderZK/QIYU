//
//  zkJuBaoView.m
//  miaoZai
//
//  Created by kunzhang on 2017/5/10.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import "zkJuBaoView.h"

@interface zkJuBaoView()


/*一半的时候的view*/
@property (nonatomic , strong)UIView * clearView;
/*取消按钮*/
@property (nonatomic , strong)UIButton * cancelBt;
@property(nonatomic,strong)NSIndexPath *indexPath;



@end

static zkJuBaoView * danli = nil;

@implementation zkJuBaoView

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



+ (zkJuBaoView *)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        danli = [[zkJuBaoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        danli.backgroundColor =[UIColor colorWithWhite:0 alpha:0.1];
        
    });
    
    return danli;
}

+ (void)showWithArray:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath{
    
    [zkJuBaoView shareInstance].indexPath = indexPath;
    [[zkJuBaoView shareInstance].subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[zkJuBaoView shareInstance].clearView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[zkJuBaoView shareInstance] addSubview:[zkJuBaoView shareInstance].clearView];
    [zkJuBaoView shareInstance].clearView.hidden = NO;
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:[zkJuBaoView shareInstance]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[zkJuBaoView shareInstance] show];
    });
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:[zkJuBaoView shareInstance] action:@selector(removeV)];
    
    [[zkJuBaoView shareInstance] addGestureRecognizer:tap];
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
        [[zkJuBaoView shareInstance].clearView addSubview:button];
        button.tag = arr.count - 1 - i;
        [button addTarget:[zkJuBaoView shareInstance] action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * view  = [[UIView alloc] initWithFrame:CGRectMake(10, 49.4, ScreenW -20 , 0.6)];
        view.backgroundColor = lineBackColor;
        [button addSubview:view];
        
        
        
    }

    
    //ScreenH - 50

    [[zkJuBaoView shareInstance].clearView addSubview:[zkJuBaoView shareInstance].cancelBt];
    [[zkJuBaoView shareInstance].cancelBt addTarget:[zkJuBaoView shareInstance] action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[zkJuBaoView shareInstance] addGestureRecognizer:tap];
    
   
    
 
}

- (void)removeV {
    
    [[zkJuBaoView shareInstance] diss];
    
}


- (void)clickAction:(UIButton *)button  {
    
    if (button.tag == 100) {
        
        [[zkJuBaoView shareInstance] diss];
    }else {
        [[zkJuBaoView shareInstance] diss];
        if ([zkJuBaoView shareInstance].delegate != nil && [self.delegate respondsToSelector:@selector(didSelectAtIndex:withIndexPath:)]) {
            [[zkJuBaoView shareInstance].delegate didSelectAtIndex:button.tag withIndexPath:self.indexPath];
        }
        
    }
    
 
}

- (void)show {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [zkJuBaoView shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [zkJuBaoView shareInstance].clearView.y = 0;
        [zkJuBaoView shareInstance].cancelBt.y = ScreenH - 50;
        if (sstatusHeight > 20) {
            [zkJuBaoView shareInstance].cancelBt.y = ScreenH - 50 - 34 ;
        }
    } completion:^(BOOL finished) {
        
        
    }];
    
}

- (void)diss {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [zkJuBaoView shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [zkJuBaoView shareInstance].clearView.y = ScreenH;
        [zkJuBaoView shareInstance].cancelBt.y = ScreenH - 50 + 200;
        
    } completion:^(BOOL finished) {
        
        [[zkJuBaoView shareInstance] removeFromSuperview];
        
    }];
    
    
}

+ (void)diss {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [zkJuBaoView shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [zkJuBaoView shareInstance].clearView.y = ScreenH;
        [zkJuBaoView shareInstance].cancelBt.y = ScreenH - 50 + 200;
        
    } completion:^(BOOL finished) {
        
        [[zkJuBaoView shareInstance] removeFromSuperview];
        
    }];
    
    
    
}




@end
