//
//  QQYYPhotoCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYPhotoCell.h"

@interface QQYYPhotoCell()

@end

@implementation QQYYPhotoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat ww = (ScreenW - 60)/3;
        CGFloat space = 7.5;
        for (int i = 0 ; i < 3; i++) {
            UIButton * imgBt =[[UIButton alloc] initWithFrame:CGRectMake(15 + i * (ww + 2*space), space, ww, ww)];
            imgBt.layer.cornerRadius = 3;
            imgBt.clipsToBounds = YES;
            imgBt.tag = 100+i;
            
            UIButton * delectBt =[[UIButton alloc] initWithFrame:CGRectMake(ww - 25, 0, 30, 30)];
            [delectBt setImage:[UIImage imageNamed:@"48"] forState:UIControlStateNormal];
            [imgBt addSubview:delectBt];
            delectBt.tag = 200+i;
            
            [imgBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [delectBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:imgBt];
        }
        
    }
    return self;
}

- (void)setIsDelect:(BOOL)isDelect {
    _isDelect = isDelect;
    for (int i = 0 ; i < 3; i++) {
        UIButton * button = (UIButton *)[self viewWithTag:200+i];
        button.hidden = !isDelect;
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    
    for (int i = 0 ; i < 3; i++) {
        
        UIButton * button = (UIButton *)[self viewWithTag:100+i];
        if (i<dataArray.count) {
            button.hidden = NO;
            if ([dataArray[i] isKindOfClass:[UIImage class]]) {
                [button setBackgroundImage:dataArray[i] forState:UIControlStateNormal];
            }else {
                if ([dataArray[i] length] == 0) {
                    UIButton * bt = (UIButton *)[self viewWithTag:200+i];
                    bt.hidden = YES;
                    button.hidden = NO;
                    [button setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                }else {
                   [button sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:dataArray[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
                }
            }
        }else {
            button.hidden = YES;
        }
        
    }
    
}

- (void)clickAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickView:isDelect:andIsAdd:withIndex:)]) {
        
        if (button.tag >= 200) {
            //点击的是删除
            [self.delegate didClickView:self isDelect:YES andIsAdd:NO withIndex:button.tag - 200];

        }else {
            
            if ([button.currentBackgroundImage isEqual:[UIImage imageNamed:@"jia"]]) {
                [self.delegate didClickView:self isDelect:NO andIsAdd:YES withIndex:button.tag - 100];
            }else {
               [self.delegate didClickView:self isDelect:NO andIsAdd:NO withIndex:button.tag - 100];
            }
            
        }
        
    }
    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
