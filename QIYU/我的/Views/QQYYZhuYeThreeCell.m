//
//  QQYYZhuYeThreeCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYZhuYeThreeCell.h"

@interface QQYYZhuYeThreeCell()
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation QQYYZhuYeThreeCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, (ScreenW -60) /4 + 30)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        
        
        
        
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat ww = (ScreenW - 60) /4;
    
    CGFloat space = 10;
    _scrollView.contentSize = CGSizeMake(20+(ww+space)*dataArray.count, ww + 30);
    for (int i = 0 ; i < dataArray.count; i ++) {
    
        UIImageView * imagV =[[UIImageView alloc] initWithFrame:CGRectMake(15+(space+ww) * i, 15,ww,ww)];
        imagV.layer.cornerRadius = 5;
        imagV.clipsToBounds = YES;
        imagV.tag = i+100;
        imagV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
        tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
        [imagV addGestureRecognizer:tap];
        [_scrollView addSubview:imagV];
        
        if ([dataArray[i] isKindOfClass:[UIImage class]]) {
            imagV.image = dataArray[i];
        }else {
            [imagV sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:dataArray[i]]] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        }
        
        
        
    }
    
    
    
}

- (void)tapInView:(UITapGestureRecognizer *)tap {
    
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    [[zkPhotoShowVC alloc] initWithArray:self.dataArray index:tag];
    
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
