//
//  QQYYHomeOneCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHomeOneCell.h"

@implementation QQYYHomeOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat ww = 80;
        CGFloat spaceBt = (ScreenW - 4*ww)/5;

        NSArray * arr = @[@"我的动态",@"交友日志",@"故事分享",@"互动问答",@"图片社",@"型男学院",@"闺蜜圈",@"版务"];
        for (int i  = 0 ; i < arr.count; i++) {

            btView  * vv  = [[btView alloc] initWithFrame:CGRectMake(spaceBt + (i % 4) * (spaceBt + ww)  ,i/4 * (ww + 10 ) + 10 ,ww, ww)];
            vv.titleLB.text = arr[i];
            vv.bt.tag = i;

            vv.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_%d",i]];
            [vv.bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:vv];

        }

        
    }
    return self;
}


- (void)clickAction:(UIButton *)button {
    if (self.indexBlock != nil ) {
        self.indexBlock(button.tag);
    }
    
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




@implementation  btView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        CGFloat imgH = 40;
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - imgH) / 2, (self.height - imgH - 20)/2 , imgH, imgH)];
//        self.imgV.backgroundColor = [UIColor redColor];
        [self addSubview:self.imgV];
        
        self.numberBt = [[UIButton alloc] initWithFrame:self.imgV.bounds];
        [self.imgV addSubview:self.numberBt];

        
        
        self.titleLB =[[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 20 , self.width, 20)];
        self.titleLB.font =[UIFont systemFontOfSize:14];
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.textColor = CharacterBlackColor;
        [self addSubview:self.titleLB];

        self.bt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.bt.frame = self.bounds;
        [self addSubview:self.bt];
        
        

    }
    return self;
}


@end
