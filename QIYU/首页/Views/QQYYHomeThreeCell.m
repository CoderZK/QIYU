//
//  QQYYHomeThreeCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHomeThreeCell.h"

@interface QQYYHomeThreeCell()
@property(nonatomic,strong)UIButton *leftBt;
@property(nonatomic,strong)UIButton *centerBt;
@property(nonatomic,strong)UIButton *rightBt;
@property(nonatomic,strong)UIView *leftV,*centerV,*rightV;
@property(nonatomic,strong)UIView *redV;
@end


@implementation QQYYHomeThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 65, 40)];
        self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.leftBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [self.leftBt setTitle:@"牵线墙" forState:UIControlStateNormal];
        [self.leftBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.leftBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        self.leftBt.titleLabel.font = kFont(15);
        
//        self.leftV = [[UIView alloc] initWithFrame:CGRectMake(38, 10, 15, 15)];
//        self.leftV.backgroundColor = RGB(250, 105, 178);
//        self.leftV.alpha = 0.5;
//        self.leftV.clipsToBounds = YES;
//        self.leftV.layer.cornerRadius = 7.5;
//        self.leftV.layer.shadowColor = ShadowColor.CGColor;
//        self.leftV.layer.shadowOffset = CGSizeMake(0, 0);
//        self.leftV.layer.shadowOpacity = 0.1;//不透明度
//        self.leftV.layer.shadowRadius = 10.0;
//        [self.leftBt addSubview:self.leftV];
        
        [self addSubview:self.leftBt];
        self.leftBt.tag = 0;
        [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.centerBt = [[UIButton alloc] initWithFrame:CGRectMake(15 +  70 , 0, 85, 40)];
        self.centerBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.centerBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [self.centerBt setTitle:@"附近的人" forState:UIControlStateNormal];
        [self.centerBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.centerBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        self.centerBt.titleLabel.font = kFont(15);
        [self addSubview:self.centerBt];
        self.centerBt.tag = 1;
        [self.centerBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        self.centerV = [[UIView alloc] initWithFrame:CGRectMake(38, 10, 15, 15)];
//        self.centerV.backgroundColor = RGB(250, 105, 178);
//        self.centerV.clipsToBounds = YES;
//        self.centerV.alpha = 0.5;
//        self.centerV.layer.cornerRadius = 7.5;
//        self.centerV.layer.shadowColor = ShadowColor.CGColor;
//        self.centerV.layer.shadowOffset = CGSizeMake(0, 0);
//        self.centerV.layer.shadowOpacity = 0.1;//不透明度
//        self.centerV.layer.shadowRadius = 10.0;
//        self.centerV.hidden = YES;
//        [self.centerBt addSubview:self.centerV];
        
        
        
//        self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(15 +  110 , 0, 50, 40)];
//        self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        self.rightBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
//        [self.rightBt setTitle:@"关注" forState:UIControlStateNormal];
//        [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        [self.rightBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
//        self.rightBt.titleLabel.font = kFont(15);
//        [self addSubview:self.rightBt];
//        self.rightBt.tag = 2;
//        [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.rightV = [[UIView alloc] initWithFrame:CGRectMake(38, 10, 15, 15)];
        self.rightV.backgroundColor = RGB(250, 105, 178);
        self.rightV.alpha = 0.5;
        self.rightV.clipsToBounds = YES;
        self.rightV.layer.cornerRadius = 7.5;
        self.rightV.layer.shadowColor = ShadowColor.CGColor;
        self.rightV.layer.shadowOffset = CGSizeMake(0, 0);
        self.rightV.layer.shadowOpacity = 0.1;//不透明度
        self.rightV.layer.shadowRadius = 10.0;
        self.rightV.hidden = YES;
        [self.rightBt addSubview:self.rightV];
        
        self.desBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 10-40, 0, 40, 40)];
        self.desBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [self.desBt setImage: [UIImage imageNamed:@"qy44"] forState:UIControlStateNormal];
        self.desBt.tag = 3;
        [self.desBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.desBt];
        
        
        self.redV = [[UIView alloc] initWithFrame:CGRectMake(15 + (85 - 30)/2.0 , 48 , 30, 3)];
        self.redV.centerX = self.leftBt.centerX;
        [self addSubview:self.redV];
        self.redV.backgroundColor = PurpleColor;
        
        
    }
    self.backgroundColor =[UIColor clearColor];
    return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (selectIndex == 0) {
        self.leftBt.selected = self.centerV.hidden = self.rightV.hidden = YES;
        self.leftV.hidden = NO;
        self.leftBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        self.rightBt.selected =  NO;
        self.rightBt.titleLabel.font = kFont(15);
        
        [UIView animateWithDuration:0.1 animations:^{
            self.redV.centerX = self.leftBt.centerX;
        }];
        
        
    }else if (selectIndex == 1) {
        self.centerBt.selected =self.leftV.hidden = self.rightV.hidden = YES;
        self.centerV.hidden = NO;
        self.centerBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.leftBt.selected = NO;
        self.leftBt.titleLabel.font = kFont(15);
        self.rightBt.selected = NO;
        self.rightBt.titleLabel.font = kFont(15);
        [UIView animateWithDuration:0.1 animations:^{
            self.redV.centerX = self.centerBt.centerX;
        }];
    }else  if (selectIndex == 2) {
        
       
    
        self.rightBt.selected = self.leftV.hidden = self.centerV.hidden = YES;
        self.rightV.hidden = NO;
        self.rightBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        self.leftBt.selected = NO;
        self.leftBt.titleLabel.font = kFont(15);
    }
    
    
    
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    if (dataArray.count > 0) {
        [self.leftBt setTitle:dataArray[0] forState:UIControlStateNormal];
    }
    if (dataArray.count > 1) {
        [self.centerBt setTitle:dataArray[1] forState:UIControlStateNormal];
    }
    if (dataArray.count > 2) {
        [self.rightBt setTitle:dataArray[2] forState:UIControlStateNormal];
    }
    
}


- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 2 && ![QQYYSignleToolNew shareTool].isLogin) {
        if (self.clickIndexBlock != nil) {
            self.clickIndexBlock(button.tag);
        }
        return;
    }
    self.selectIndex = button.tag;
    if (self.clickIndexBlock != nil) {
        self.clickIndexBlock(button.tag);
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
