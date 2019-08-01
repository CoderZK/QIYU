//
//  QQYYGongGaoThreeCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYGongGaoThreeCell.h"

@interface QQYYGongGaoThreeCell()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *titleLB,*numberLB;
@end

@implementation QQYYGongGaoThreeCell
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, ScreenW  , 70)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 80, 20)];
        self.titleLB.text = @"关注人数";
        self.titleLB.font = kFont(15);
        self.titleLB.textColor = [UIColor darkGrayColor];
        [self addSubview:self.titleLB];
        
        self.numberLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, ScreenW - 80, 20)];
        self.numberLB.font = kFont(14);
        self.numberLB.textColor = CharacterBlackColor;
        self.numberLB.text = @"905748";
        [self addSubview:self.numberLB];
        
        
        UIImageView  * imgV =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 35, 15, 20, 20)];
        [self addSubview:imgV];
        imgV.image = [UIImage imageNamed:@"more"];
        
        
        [self addSubview:self.scrollView];
        
        
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray<zkHomelModel *> *)dataArray {
    _dataArray = dataArray;
    self.scrollView.contentSize = CGSizeMake(dataArray.count * 65 + 15, 50);
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0;i < dataArray.count; i++) {
        
        UIButton  * button = [[UIButton alloc] initWithFrame:CGRectMake(15+(50+15)*i, 15, 50, 50)];
        button.layer.cornerRadius = 25;
        button.clipsToBounds = YES;
        button.tag = 100 + i;
        [self.scrollView addSubview:button];
        [button addTarget:self action:@selector(clcikAction:) forControlEvents:UIControlEventTouchUpInside];
        [button sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:[QQYYURLDefineTool getImgURLWithStr:dataArray[i].avatar]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    }
    
    self.numberLB.text = self.numberStr;
    
}

- (void)clcikAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickGuanZhuBtWithIndex:)]) {
        [self.delegate didClickGuanZhuBtWithIndex:button.tag - 100];
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
