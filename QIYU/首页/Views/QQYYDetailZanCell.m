//
//  QQYYDetailZanCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYDetailZanCell.h"

@interface QQYYDetailZanCell()
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation QQYYDetailZanCell

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 50 , 70)];
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
        
        [self addSubview:self.scrollView];
        self.moreBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 50, 0, 50, 65)];
        [self addSubview:self.moreBt];
        [self.moreBt setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
     self.scrollView.contentSize = CGSizeMake(dataArray.count * 65 + 15, 65);
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0;i < dataArray.count; i++) {
        
        UIButton  * button = [[UIButton alloc] initWithFrame:CGRectMake(15+(45+15)*i, 10, 45, 45)];
        button.layer.cornerRadius = 22.5;
        button.clipsToBounds = YES;
        button.tag = 100 + i;
        [self.scrollView addSubview:button];
        [button addTarget:self action:@selector(clcikAction:) forControlEvents:UIControlEventTouchUpInside];
        [button sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:dataArray[i]]] forState:UIControlStateNormal];
    }
   
    
}

- (void)setDataArrayTwo:(NSMutableArray<zkHomelModel *> *)dataArrayTwo {
    
    _dataArrayTwo = dataArrayTwo;
    self.scrollView.contentSize = CGSizeMake(dataArrayTwo.count * 65 + 15, 65);
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0;i < dataArrayTwo.count; i++) {
        
        UIButton  * button = [[UIButton alloc] initWithFrame:CGRectMake(15+(45+15)*i, 10, 45, 45)];
        button.layer.cornerRadius = 5;
        button.clipsToBounds = YES;
        button.tag = 100 + i;
        [self.scrollView addSubview:button];
        [button addTarget:self action:@selector(clcikAction:) forControlEvents:UIControlEventTouchUpInside];
        [button sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:dataArrayTwo[i].avatar] ] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    }
    
    
}

- (void)clcikAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickZanHeadBtWithIndex:)]) {
        [self.delegate didClickZanHeadBtWithIndex:button.tag - 100];
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
