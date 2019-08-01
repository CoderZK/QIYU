//
//  QQYYDongTaiDetailCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYDongTaiDetailCell.h"
@interface QQYYDongTaiDetailCell()
@property(nonatomic,strong)UIButton *zanBt,*pingBt,*scanBt,*LikeBt,*shareBt,*moreContentBt,*sexBt,*biaoQianOneBt,*biaoQianTwoBt;
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UILabel *nameLB,*contentLB,*timeLB,*desLB;
@property(nonatomic,strong)UIView *zanView ,* pingAndZanV,*picsView;
@property(nonatomic,strong)UITableView *tabelView;
@property(nonatomic,strong)UIView *grayV,*xiaDanV;
@property(nonatomic,strong)UIImageView *huanGuanImgV;
@end

@implementation QQYYDongTaiDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       
        
        self.backgroundColor = WhiteColor;
        //头像
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 45, 45);
        self.headBt.layer.cornerRadius = 5;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.headBt.tag = 100;
        //昵称
        self.nameLB =[[UILabel alloc] initWithFrame:CGRectMake(70, 20 , 120, 20)];
        self.nameLB.text = @"来啊";
        self.nameLB.font =[UIFont systemFontOfSize:14 weight:0.2];
        self.nameLB.textColor = CharacterBlackColor;
        [self addSubview:self.nameLB];
        
        
        self.sexBt = [[UIButton alloc] init];
        [self.sexBt setTitle:@"19" forState:UIControlStateNormal];
        self.sexBt.titleLabel.font = kFont(10);
        [self addSubview:self.sexBt];
        self.biaoQianOneBt = [[UIButton alloc] init];
        [self addSubview:self.biaoQianOneBt];
        [self.biaoQianOneBt setTitle:@"19" forState:UIControlStateNormal];
        self.biaoQianOneBt.titleLabel.font = kFont(10);
        
        self.biaoQianTwoBt = [[UIButton alloc] init];
        [self addSubview:self.biaoQianTwoBt];
        [self.biaoQianTwoBt setTitle:@"19" forState:UIControlStateNormal];
        self.biaoQianTwoBt.titleLabel.font = kFont(10);
        self.sexBt.frame = CGRectMake(CGRectGetMaxX(self.headBt.frame) + 15 , CGRectGetMaxY(self.nameLB.frame) + 10 , 40, 15);
        self.biaoQianOneBt.frame = CGRectMake(CGRectGetMaxX(self.sexBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40, 15);
        self.biaoQianTwoBt.frame = CGRectMake(CGRectGetMaxX(self.biaoQianOneBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40, 15);
        [self.biaoQianOneBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [self.biaoQianTwoBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        self.sexBt.clipsToBounds = self.biaoQianTwoBt.clipsToBounds = self.biaoQianOneBt.clipsToBounds = YES;
         self.biaoQianOneBt.hidden = self.biaoQianTwoBt.hidden = YES;
        //皇冠
        self.huanGuanImgV = [[UIImageView alloc] init];
        [self addSubview:self.huanGuanImgV];
        self.huanGuanImgV.size = CGSizeMake(17, 17);
        self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame);
        self.huanGuanImgV.image =[UIImage imageNamed:@"huanguan"];
        self.huanGuanImgV.centerY = self.nameLB.centerY;
        
        //时间
        self.timeLB = [[UILabel alloc] init];
        self.timeLB.text = @"上海 05-06";
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = CharacterBackColor;
        [self addSubview:self.timeLB];
        self.timeLB.textAlignment = NSTextAlignmentRight;
        
        [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.nameLB.mas_centerY);
            make.left.equalTo(self.huanGuanImgV.mas_right).offset(3);
        }];
        
        self.cancelBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 30 - 25, 45 , 25, 25)];
        [self.cancelBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        [self.cancelBt setImage:[UIImage imageNamed:@"31"] forState:UIControlStateNormal];
        self.cancelBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.cancelBt.tag = 107;
        self.cancelBt.titleLabel.font = kFont(13);
        [self.cancelBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.cancelBt];
//        self.cancelBt.hidden = YES;
        
        
        //内容
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 75, ScreenW - 30, 20)];
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        
        //更多
        self.moreContentBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moreContentBt.frame = CGRectMake(ScreenW - 70 , CGRectGetMaxY(self.contentLB.frame) , 60, 30);
        [self.moreContentBt setTitle:@"查看全文" forState:UIControlStateNormal];
        [self.moreContentBt setTitleColor:CharacterRedColor forState:UIControlStateNormal];
        self.moreContentBt.titleLabel.font = kFont(14);
        //        self.moreContentBt.userInteractionEnabled = NO;
        [self.moreContentBt sizeToFit];
        [self addSubview:self.moreContentBt];
        [self.moreContentBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.moreContentBt.tag = 106;
        
        //图片
        self.picsView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.moreContentBt.frame), ScreenW - 30, 20)];
        for (int i = 0 ; i < 9 ; i ++) {
            
            UIImageView * imageView= [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
            tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.picsView addSubview:imageView];
            imageView.layer.cornerRadius = 5;
            imageView.clipsToBounds = YES;
        }
        
        [self addSubview:self.picsView];
        
        
        self.desLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.picsView.frame) + 10 , ScreenW - 30, 20)];
        self.desLB.text = @"女王范 实力撩 问答";
        self.desLB.font = kFont(12);
        self.desLB.textColor = CharacterBackColor;
        [self addSubview:self.desLB];
        
        self.zanView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.desLB.frame)+10, ScreenW, 40)];
        [self addSubview:self.zanView];
        
        self.scanBt = [self getBt];
        [self.scanBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.scanBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        self.scanBt.frame = CGRectMake(15, 5, (ScreenW-30)/5, 30);
        [self.scanBt setImage:[UIImage imageNamed:@"qy8"] forState:UIControlStateNormal];
        [self.scanBt setTitle:@"4527" forState:UIControlStateNormal];
        [self.scanBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.scanBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.zanView addSubview:self.scanBt];
        
        self.pingBt = [self getBt];
        self.pingBt.frame = CGRectMake(CGRectGetMaxX(self.scanBt.frame), 5, (ScreenW-30)/5, 30);
        [self.pingBt setImage:[UIImage imageNamed:@"qy9"] forState:UIControlStateNormal];
        [self.pingBt setTitle:@"4527" forState:UIControlStateNormal];
        [self.pingBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.pingBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.zanView addSubview:self.pingBt];
        
        
        self.zanBt = [self getBt];
        self.zanBt.frame = CGRectMake(CGRectGetMaxX(self.pingBt.frame), 5, (ScreenW-30)/5, 30);
        [self.zanBt setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [self.zanBt setTitle:@"4527" forState:UIControlStateNormal];
        [self.zanBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.zanBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.zanView addSubview:self.zanBt];
        
        self.LikeBt = [self getBt];
        self.LikeBt.frame = CGRectMake(CGRectGetMaxX(self.zanBt.frame), 5, (ScreenW-30)/5, 30);
        [self.LikeBt setImage:[UIImage imageNamed:@"qy11"] forState:UIControlStateNormal];
        [self.LikeBt setTitle:@"4527" forState:UIControlStateNormal];
        [self.LikeBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.LikeBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.zanView addSubview:self.LikeBt];
        
        self.shareBt = [self getBt];
        self.shareBt.frame = CGRectMake(CGRectGetMaxX(self.LikeBt.frame), 5, (ScreenW-30)/5, 30);
        [self.shareBt setImage:[UIImage imageNamed:@"qy12"] forState:UIControlStateNormal];
        [self.shareBt setTitle:@"" forState:UIControlStateNormal];
        [self.shareBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.shareBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.zanView addSubview:self.shareBt];
        
        
        [self.scanBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.scanBt.tag = 101;
        [self.pingBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.pingBt.tag = 102;
        [self.zanBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.zanBt.tag = 103;
        [self.LikeBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.LikeBt.tag = 104;
        [self.shareBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.shareBt.tag = 105;
        
        
        
//        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, self.zanView.mj_h - 0.6 , ScreenW, 0.6)];
//        backV.backgroundColor = lineBackColor;
//        self.lineV = backV;
//        [self.zanView addSubview:backV];
        
     
        
        
        
    }
    return self;
}


- (void)clickAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickButtonWithCell:andIndex:)]) {
        [self.delegate didClickButtonWithCell:self andIndex:button.tag - 100];
    }
    
    
}

- (UILabel *)getLB {
    UILabel * lb = [[UILabel alloc] init];
    return lb;
}

- (UIButton *)getBt {
    UIButton * button = [[UIButton alloc] init];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    button.titleLabel.font = kFont(10);
    return button;
}


- (void)setImgViews:(NSArray *)arr {
//    arr = @[@"http://p0.qhimgs4.com/t01d406e56973481579.jpg",@"http://5b0988e595225.cdn.sohucs.com/images/20190508/a3df05de51954e2891f829380af31754.jpeg",@"http://5b0988e595225.cdn.sohucs.com/images/20190507/2e2a6a6e43304433bd7a558292fcb487.jpeg",@"http://b-ssl.duitang.com/uploads/item/201804/06/20180406212446_mclnu.jpg"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = arr.count; i < 9; i++) {
            UIImageView * imgV = [self.picsView viewWithTag:100+i];
            imgV.hidden = YES;
        }
    });
    
    if (arr.count == 0 ) {
        self.picsView.mj_h = 0;
        return;
    }
    
    CGFloat space = 10;
    CGFloat ww = (ScreenW - 30 - 2*space) / 3;
    CGFloat hh = 0;
    for (int i = 0 ; i < arr.count; i++) {
        UIImageView * imgV = [self.picsView viewWithTag:100+i];
        imgV.hidden = NO;
        if (arr.count == 1) {
            //一张图片的布局
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = 0;
            imgV.mj_y = 0;
            hh = ww;
            
        }else if (arr.count == 4) {
            //四张的布局
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = (ww + space) * (i % 2);
            imgV.y = (ww + space) * (i / 2);
            hh = CGRectGetMaxY(imgV.frame);
            
        }else {
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = (ww + space) * (i % 3);
            imgV.y = (ww + space) * (i / 3);
            hh = CGRectGetMaxY(imgV.frame);
        }
        [imgV sd_setImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:arr[i]]] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    }
    self.picsView.mj_h = hh;
    
}

- (void)setModel:(zkHomelModel *)model {
    
    _model = model;
    
    
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:model.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = model.nickName;
    
    [self.nameLB sizeToFit];
    self.nameLB.height = 20;
    self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame) + 10;
    
    if (model.isVip) {
        self.huanGuanImgV.hidden = NO;
    }else {
        self.huanGuanImgV.hidden = YES;
    }
    if (model.currentUserCollect) {
        [self.cancelBt setImage:[UIImage imageNamed:@"79"] forState:UIControlStateNormal];
    }else {
        [self.cancelBt setImage:[UIImage imageNamed:@"31"] forState:UIControlStateNormal];
    }
    if (model.currentUserLike) {
        [self.zanBt setImage:[UIImage imageNamed:@"zan1"] forState:UIControlStateNormal];
    }else {
        [self.zanBt setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    }
    
    
    self.timeLB.text = [NSString stringWithFormat:@"%@-%@ %@",model.provinceName,model.cityName,[NSString stringWithTime:model.createTime]];
    self.timeLB.mj_w = [[NSString stringWithFormat:@"%@-%@ %@",model.provinceName,model.cityName,[NSString stringWithTime:model.createTime]] getWidhtWithFontSize:13];
  
    NSArray *  arr = [model.userTags componentsSeparatedByString:@","];
    NSString * strTwo = @"";
    if (arr.count > 0) {
        strTwo = [NSString stringWithFormat:@"%@ %@ ∙ %@",[sxeArr objectAtIndex:model.gender],model.age,arr[0]];
    }
    if (arr.count > 1) {
        strTwo = [NSString stringWithFormat:@"%@ %@ ∙ %@ ∙ %@",[sxeArr objectAtIndex:model.gender],model.age,arr[0],arr[1]];
    }
    
    [self.sexBt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)model.gender + 89]] forState:UIControlStateNormal];
    //    NSString *sexStr = [NSString stringWithFormat:@"%@ %@",[sxeArr objectAtIndex:model.gender],model.age];
    [self.sexBt setTitle:strTwo forState:UIControlStateNormal];
    self.sexBt.mj_w = 15+ [strTwo getWidhtWithFontSize:10];
    self.sexBt.layer.cornerRadius  = 3;
    self.sexBt.clipsToBounds = YES;
    self.biaoQianTwoBt.hidden =  self.biaoQianOneBt.hidden = YES;
    
//    NSArray *  arr = [model.userTags componentsSeparatedByString:@","];
//    self.biaoQianTwoBt.hidden =  self.biaoQianOneBt.hidden = YES;
//    if (arr.count > 0) {
//        self.biaoQianOneBt.hidden = NO;
//        [self.biaoQianOneBt setTitle:arr[0] forState:UIControlStateNormal];
//        self.biaoQianOneBt.mj_w = [arr[0] getWidhtWithFontSize:10] + 15 ;
//        self.biaoQianOneBt.mj_x = CGRectGetMaxX(self.sexBt.frame) + 15;
//    }
//
//    if (arr.count > 1) {
//        self.biaoQianTwoBt.hidden = NO;
//        [self.biaoQianTwoBt setTitle:arr[1] forState:UIControlStateNormal];
//        self.biaoQianTwoBt.mj_w = [arr[1] getWidhtWithFontSize:10] + 15 ;
//        self.biaoQianTwoBt.mj_x = CGRectGetMaxX(self.biaoQianOneBt.frame) + 15;
//    }
//
//    self.sexBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.sexBt andRadi:7.5];
//    self.biaoQianOneBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.biaoQianOneBt andRadi:7.5];
//    self.biaoQianTwoBt.layer.mask = [QQYYpublicFunction getBezierWithFrome:self.biaoQianTwoBt andRadi:7.5];
    
    NSString * str = model.content;
    CGFloat hh = [@"谁" getSizeWithMaxSize:CGSizeMake(100, 100) withFontSize:14].height;
    
    CGFloat ch= [str getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 60];
    
    if (ch > hh * 3 + 3*2) {
        ch = hh * 3 + 3*2;
        self.contentLB.height = ch;
        NSString * str2 = [NSString stringWithFormat:@"%@查看原文",str];
        self.contentLB.attributedText = [str2 getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlackColor textColorTwo:CharacterRedColor nsrange:NSMakeRange(str2.length - 4, 4)];
    }else {
        self.contentLB.height = ch;
        self.contentLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlackColor];
    }
        
    
    self.picsView.mj_y = CGRectGetMaxY(self.moreContentBt.frame) + 10 ;
    if (self.isDetail) {
        self.contentLB.height = ch;
        self.moreContentBt.hidden = YES;
        self.picsView.mj_y = CGRectGetMaxY(self.contentLB.frame) + 10 ;
    }
    
   if (model.pic.length == 0) {
        [self setImgViews:@[]];
    }else {
        [self setImgViews:[model.pic componentsSeparatedByString:@","]];
    }
    
//    self.desLB.text = [model.tagName stringByReplacingOccurrencesOfString:@"," withString:@"  "];
    self.desLB.text = model.circleName;
    
    [self.scanBt setTitle:[NSString stringWithFormat:@"%ld",model.clickNum] forState:UIControlStateNormal];
    [self.pingBt setTitle:[NSString stringWithFormat:@"%ld",model.replyNum] forState:UIControlStateNormal];
    [self.LikeBt setTitle:[NSString stringWithFormat:@"%ld",model.heat] forState:UIControlStateNormal];
    [self.zanBt setTitle:[NSString stringWithFormat:@"%ld",model.likeNum] forState:UIControlStateNormal];
    
    
    self.desLB.mj_y = CGRectGetMaxY(self.picsView.frame) + 10;
    self.zanView.mj_y = CGRectGetMaxY(self.desLB.frame) + 0;
    
    model.cellHeight = CGRectGetMaxY(self.zanView.frame);
    
}

- (void)tapInView:(UITapGestureRecognizer *)tap {
    
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    NSArray * arr = [self.model.pic componentsSeparatedByString:@","];
    NSMutableArray * picArr = @[].mutableCopy;
    for (NSString * str  in arr) {
        [picArr addObject:[NSString stringWithFormat:@"%@",[QQYYURLDefineTool getImgURLWithStr:str]]];
    }
    
    [[zkPhotoShowVC alloc] initWithArray:picArr index:tag];
    
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

