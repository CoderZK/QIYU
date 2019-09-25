//
//  QQYYYongBaoView.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYYongBaoView.h"

@interface QQYYYongBaoView()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,assign)NSInteger number;
@end

@implementation QQYYYongBaoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        [self addSubview:button];
        [button addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        CGFloat hh = 207;
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(20, (ScreenH - hh)/2, ScreenW - 40 ,hh)];
        self.whiteV.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.clipsToBounds = YES;
        
        NSArray * arr1 = @[@"x20",@"x50",@"x100"];
        NSArray * arr2 = @[@"送一下",@"连送爱豆",@"疯狂送爱豆"];
        CGFloat ww = 60;
        CGFloat space = (ScreenW - 40 - 3*ww)/6;
        
        UIButton * chaBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 40 - 25, 2, 20, 20)];
        [chaBt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [self.whiteV addSubview:chaBt];
        [chaBt addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        
        
        for (int i = 0 ; i < 3 ; i++) {
        
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(space + space * 2* i + ww * i , 40 , ww, ww)];
            [self.whiteV addSubview:button];
            button.tag = 100+i;
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake((ww - 40)/2, 0, 40, 40)];
//            imgV.backgroundColor = [UIColor greenColor];
            imgV.image = [UIImage imageNamed:@"19"];
            [button addSubview:imgV];
            
            
            
            UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, ww - 18, ww, 18)];
            lb.font = kFont(14);
            lb.text = arr2[i];
            lb.textColor = CharacterBlackColor;
            lb.textAlignment = NSTextAlignmentCenter;
            [button addSubview:lb];
            
            UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 40, 16)];
            lb2.font = kFont(13);
            lb2.textColor = CharacterRedColor;
            lb2.text = arr1[i];
            lb2.textAlignment = NSTextAlignmentLeft;
            [button addSubview:lb2];

        }
        
        
        UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(10, ww + 40 , ScreenW - 40 - 20 , 0.6)];
        lineV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:lineV];
        
        
        UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineV.frame) + 3, ScreenW - 40 , 16)];
        lb3.font = kFont(12);
        lb3.textColor = CharacterBackColor;
        lb3.text = @"或";
        lb3.textAlignment = NSTextAlignmentCenter;
        [self.whiteV addSubview:lb3];
        
        
        self.TF = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lb3.frame), ScreenW - 40 - 20, 35)];
        self.TF.font = kFont(14);
        self.TF.delegate = self;
        self.TF.backgroundColor = RGB(245, 245, 245);
        [self.TF setTintColor:CharacterRedColor];
        self.TF.textAlignment = NSTextAlignmentCenter;
        self.TF.placeholder = @"自定义数量";
        self.TF.keyboardType = UIKeyboardTypeNumberPad;
        [self.whiteV addSubview:self.TF];
        
        UIView * lineV2 = [[UIView alloc] initWithFrame:CGRectMake((ScreenW - 40) / 2 - 0.4 , CGRectGetMaxY(self.TF.frame), 0.5, 35)];
        lineV2.backgroundColor = lineBackColor;
        [self.whiteV addSubview:lineV2];
        
        UIButton * confrimBt = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TF.frame) + 10, (ScreenW - 40)/2, 35)];
        confrimBt.tag = 103;
        confrimBt.titleLabel.font = kFont(14);
        [confrimBt setTitle:@"确认送爱豆" forState:UIControlStateNormal];
//        [confrimBt setTitleColor:RGB(6, 174, 243) forState:UIControlStateNormal];
        [confrimBt setTitleColor:CharacterRedColor forState:UIControlStateNormal];
        [confrimBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:confrimBt];
        
        
        UIButton * chongZhiBt = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 40)/2, CGRectGetMaxY(self.TF.frame) + 10, (ScreenW - 40)/2, 35)];
        chongZhiBt.tag = 104;
        chongZhiBt.titleLabel.font = kFont(14);
        [chongZhiBt setTitle:@"购买爱豆" forState:UIControlStateNormal];
        if (isDDDDDDDD) {
            [chongZhiBt setTitle:@"取消" forState:UIControlStateNormal];;
        }
//        [chongZhiBt setTitleColor:RGB(6, 174, 243) forState:UIControlStateNormal];
         [chongZhiBt setTitleColor:CharacterRedColor forState:UIControlStateNormal];
        [chongZhiBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:chongZhiBt];
        

        
        
        
    }
    return self;
    
}


- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        self.number+=20;
        
    }else if (button.tag == 101) {
        self.number+=50;
    }else if (button.tag == 102) {
        self.number+=100;
    }else {
        [self diss];
        if (isDDDDDDDD && button.tag == 104 ) {
            return;
        }
        if (self.deletage != nil && [self.deletage respondsToSelector:@selector(didClcikIndex:withIndexPath:WithNumber:)]) {
            
            [self.deletage didClcikIndex:button.tag - 100 withIndexPath:self.indexPath WithNumber:self.TF.text];
            
        }
    }
    self.TF.text = [NSString stringWithFormat:@"%ld",self.number];
    
}

- (void)showWithIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    [self show];
    
}


- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.4];
        self.whiteV.transform = CGAffineTransformMakeScale(1, 1);
        
    }completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)diss {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.whiteV.transform = CGAffineTransformMakeScale(0.4, 0.4);
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    self.number = [textField.text integerValue];

}


@end
