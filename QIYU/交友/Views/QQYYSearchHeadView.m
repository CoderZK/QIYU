//
//  QQYYSearchHeadView.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYSearchHeadView.h"


@interface QQYYSearchHeadView()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,assign)NSInteger selectTag;
@end

@implementation QQYYSearchHeadView

- (void)clickAction:(UIButton *)bt {
    BOOL isShow = NO;
    for (int i = 1000 ; i < 1004 ; i++) {
        UIButton * button = [self viewWithTag:i];
        if (bt == button ) {
            if (bt.selected == NO) {
                isShow = YES;
                bt.selected = YES;
            }else {
                isShow =  bt.selected = NO;
            }
           
        }else {
            [button setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
            button.selected = NO;
        }
    }
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickIndex:withIsShow:)]) {
        [self.delegate didClickIndex:bt.tag - 1000 withIsShow:isShow];
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
       // 45 + 78
        CGFloat space = (ScreenW- (55*2+88 * 2)-30) / 3;
        NSArray * widhtArr = @[@55,@55,@88,@88];
        CGFloat x=0;
        NSArray * arr = @[@"性别",@"兴趣",@"常住地区",@"感情状态"];
        for (int i  = 0 ; i < arr.count; i++) {
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x + space * i, 5, [widhtArr[i] floatValue], 40)];
            [button setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"shang"] forState:UIControlStateSelected];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
            button.titleLabel.font = kFont(14);
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            x=x+[widhtArr[i] floatValue];
            button.tag = 1000+i;
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
    }
    return self;
}
- (void)cancel{
    for (int i = 1000 ; i < 1004 ; i++) {
        UIButton * button = [self viewWithTag:i];
        button.selected = NO;
        [button setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
    }
    
}

-(void)LJOne {
    for (int i = 0 ; i<100; i++ ) {
        
        int d = arc4random() % 6 + 4;
        if (d % 3 == 0) {
            d = d+1;
            NSLog(@"%d",d);

        }
        
    }
}

- (void)LJTwo {
    for (int i = 5 ; i<10; i++) {
        
        int e = arc4random() % 9;
        if (e / 3 == 0){
            e = e*e;
            NSLog(@"%d",e);

        }
        
    }
}

@end
