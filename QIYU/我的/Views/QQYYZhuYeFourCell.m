//
//  QQYYZhuYeFourCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYZhuYeFourCell.h"

@interface QQYYZhuYeFourCell()

@end

@implementation QQYYZhuYeFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW -30 , 20)];
        self.titleLB.textColor = CharacterBlackColor;
        self.titleLB.font = kFont(14);
        self.titleLB.text = @"请选择符合自己的标签";
        [self addSubview:self.titleLB];
        
        self.gotoImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 35, 15, 20,20)];
        self.gotoImgV.image = [UIImage imageNamed:@"more"];
        [self addSubview:_gotoImgV];
        self.gotoImgV.hidden = YES;
        
        
        self.biaoQianLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 45 , ScreenW -30 , 20)];
        self.biaoQianLB.textColor = CharacterBlackColor;
        self.biaoQianLB.font = kFont(14);
        self.biaoQianLB.text = @"已经选择标签 (7)";
        [self addSubview:self.biaoQianLB];
        
//        self.whiteView =  [[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenW, 0)];
        self.whiteView = [[UIView alloc] init];
        self.whiteView.backgroundColor = WhiteColor;
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@80);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@-15);
            
        }];
        
        
    }
    return self;
}

- (void)setArr:(NSArray *)arr {
    _arr  = arr;
    
    CGFloat XX = 15;
    CGFloat totalW = XX;
    NSInteger number = 1;
    CGFloat btH = 30;
    CGFloat spaceW = 10;
    CGFloat spaceH = 10;
    CGFloat btY0 = 0;
    
    [self.whiteView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    for (int i = 0 ; i < arr.count; i++) {
        
        UIButton * button = (UIButton *)[self.whiteView viewWithTag:100+i];
        
        if (button==nil) {
            button =[UIButton new];
        }
        
        // button.hidden = YES;
        button.tag = 100+i;
        [button setTitleColor:CharacterBlack40 forState:UIControlStateNormal];
        //[button setImage:[UIImage imageNamed:@"biaoqian"] forState:UIControlStateNormal];
        //button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        //[button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        button.backgroundColor = RGB(245, 245, 245);
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        
//        [button addTarget:self action:@selector(clickNameAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString * str = [NSString stringWithFormat:@"%@",arr[i]];
        
        
        [button setTitle:str forState:UIControlStateNormal];
        CGFloat width =[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
        
        button.x = totalW;
        button.y = btY0+(number-1) *(btH+spaceH);
        button.height =btH;
        button.width = width+30;
        totalW = button.x + button.width + spaceW;
 
        if(totalW  > ScreenW - 30) {
            totalW = XX;
            number +=1;
            button.x =totalW;
            button.y =btY0+ (number-1) *(btH + spaceH);
            button.height = btH;
            button.width = width+30;
            totalW = button.x + button.width + spaceW;
        }
        if (i == arr.count - 1) {
            CGFloat hh = CGRectGetMaxY(button.frame);
            if (self.type == 1) {
                [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(50);
                    make.height.equalTo(@(hh));
                }];
                self.model.cellHeight = 50 + hh+15;
            }else {
                [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.height.equalTo(@(hh));
                }];
                self.model.cellHeight = 80 + hh+15;
            }
          
        }
        
        [self.whiteView addSubview:button];
        
    }
    
    
    
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 1) {
        self.gotoImgV.hidden = NO;
        self.biaoQianLB.hidden = YES;
       
    }
}

- (void)setModel:(QQYYUserModel *)model {
    _model = model;
  
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
