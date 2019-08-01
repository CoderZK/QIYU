//
//  QQYYHomeFiveCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYHomeFiveCell.h"
#import "QQYYHomeOneCell.h"
@interface QQYYHomeFiveCell()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *view1,*view2;
@property(nonatomic,assign)CGFloat conWW;
@end

@implementation QQYYHomeFiveCell
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, ScreenW  , 120)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
//        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       
        self.backgroundColor = WhiteColor;
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
        self.imgV.image = [UIImage imageNamed:@"qy43"];
        [self addSubview:self.imgV];
        
        [self addSubview:self.scrollView];
        
        self.scrollView.backgroundColor =[UIColor clearColor];
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake((ScreenW - 50)/2,  CGRectGetMinY(self.scrollView.frame) + 126, 50, 4)];
        self.view1.layer.cornerRadius = 2;
        self.view1.clipsToBounds = YES;
        self.view1.backgroundColor = RGB(211, 211, 211);
        [self addSubview:self.view1];
        
        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 4)];
        self.view2.backgroundColor = RGB(128, 108, 143);
        self.view2.layer.cornerRadius = 2;
        self.view2.clipsToBounds = YES;
        [self.view1 addSubview:self.view2];
        
        
        
    }
    return self;
}


- (void)setDataArray:(NSMutableArray<QQYYTongYongModel *> *)dataArray {
    _dataArray = dataArray;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat ww = 70;
    CGFloat hh = 95 ;
    CGFloat spaceBt = 0;
    
//    NSArray * arr = @[@"灵魂伴侣",@"因材施教",@"萝莉大叔",@"答疑解惑",@"志同道合",@"花花世界",@"秘密花园",@"面经交流"];
    self.conWW = 15 + dataArray.count * (ww) + (dataArray.count - 1) * spaceBt + 15;
    self.scrollView.contentSize = CGSizeMake(_conWW, 120);
    for (int i  = 0 ; i < dataArray.count; i++) {
        
        fiveView  * vv  = [[fiveView alloc] initWithFrame:CGRectMake(15 + (i) * (spaceBt + ww)  , 20 ,ww, hh)];
//        vv.backgroundColor = WhiteColor;
//        vv.layer.shadowColor = ShadowColor.CGColor;
//        // 阴影偏移，默认(0, -3)
//        vv.layer.shadowOffset = CGSizeMake(0,0);
//        // 阴影透明度，默认0
//        vv.layer.shadowOpacity = 0.1;
//        // 阴影半径，默认3
//        vv.layer.shadowRadius = 5;
//        vv.layer.cornerRadius = 10;
        
        vv.titleLB.text = dataArray[i].name;
        vv.bt.tag = i;
        [vv.imgV sd_setImageWithURL:[NSURL URLWithString:dataArray[i].url] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"qy%d",i+22]] options:SDWebImageRetryFailed];
//        vv.imgVTwo.image = [UIImage imageNamed:[NSString stringWithFormat:@"qy%d",i+22]];
        [vv.bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:vv];
        
    }
    
    
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    NSLog(@"\n====%@",NSStringFromCGPoint(point));

    CGFloat totalContentX = self.conWW - ScreenW;
    
    CGFloat xx = (25 * point.x)/totalContentX;
    
    self.view2.mj_x = xx;
    
    
    
    

    
}



- (void)clickAction:(UIButton *)button {

    if (self.clickIndexBlock != nil) {
        self.clickIndexBlock(button.tag);
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end



@implementation  fiveView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        CGFloat imgH = 50;
        
        self.imgVTwo = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imgVTwo];
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - imgH) / 2, (self.height - imgH - 20)/2, imgH, imgH)];
        //        self.imgV.backgroundColor = [UIColor redColor];
        [self addSubview:self.imgV];
        
        self.titleLB =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgV.frame) + 10  , self.width, 20)];
        self.titleLB.font =[UIFont systemFontOfSize:12];
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.textColor = WhiteColor;
        [self addSubview:self.titleLB];
        
        self.bt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.bt.frame = self.bounds;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self addSubview:self.bt];
        
    }
    return self;
}


@end
