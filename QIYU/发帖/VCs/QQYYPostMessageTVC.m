//
//  QQYYPostMessageTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYPostMessageTVC.h"
#import "QQYYQuanZiGuiZeListTVC.h"
#import "QQYYTongXunLuTVC.h"
#import "QQYYHuaTiTVC.h"
#import "QQYYAddLinkVC.h"
#import "zkShowVIew.h"
@interface QQYYPostMessageTVC ()<zkShowVIewDelegate>
@property(nonatomic,strong)UIView  *headView,*linkV,*bottomView;
@property(nonatomic,strong)UILabel *rightLB,*desLB,*tiXingLB;
@property(nonatomic,strong)UIButton *BT,*linkBt,*huaTiView;
@property(nonatomic,strong)IQTextView *TV;
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)NSMutableArray *picsArr,*picsStrArr;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *huaTiArr;
@property(nonatomic,strong)NSString *linkStr ,*circleID,*circleName;
@property(nonatomic,strong)NSMutableArray *selectFriendsArr;
@property(nonatomic,strong)zkShowVIew *showView;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *dataArray;
@property(nonatomic,strong)NSString *idStr,*nickNameStr;
@end

@implementation QQYYPostMessageTVC

- (NSMutableArray *)selectFriendsArr {
    if (_selectFriendsArr == nil) {
        _selectFriendsArr = [NSMutableArray array];
    }
    return _selectFriendsArr;
}
- (NSMutableArray *)picsArr {
    if (_picsArr == nil) {
        _picsArr = [NSMutableArray array];
    }
    return _picsArr;
}


- (NSMutableArray *)picsStrArr {
    if (_picsStrArr == nil) {
        _picsStrArr = [NSMutableArray array];
    }
    return _picsStrArr;
}

- (zkShowVIew *)showView {
    if (_showView == nil) {
        _showView = [[zkShowVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _showView.deleate  = self;
    }
    return _showView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.dataArray = @[].mutableCopy;
    
    self.huaTiArr = @[].mutableCopy;
    
    self.navigationItem.title = @"发帖";
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW , ScreenH  - 50);
    if (sstatusHeight > 20) {
         self.tableView.frame = CGRectMake(0, 0, ScreenW , ScreenH  - 50 - 34 );
    }
    
    UIButton * newClickUpAndInsideBT=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 30)];
    
    [newClickUpAndInsideBT setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    [newClickUpAndInsideBT setTitle:@"发布" forState:UIControlStateNormal];
//    newClickUpAndInsideBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    newClickUpAndInsideBT.layer.cornerRadius = 4;
    newClickUpAndInsideBT.clipsToBounds = YES;
    newClickUpAndInsideBT.titleLabel.font = kFont(14);
    [newClickUpAndInsideBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newClickUpAndInsideBT addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    newClickUpAndInsideBT.tag = 11;
    //    [self.view addSubview:newClickUpAndInsideBT];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:newClickUpAndInsideBT];
    
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
 
    [self createViews];
    
    [self acquireDataFromServe];
    
    
    
    
}

- (void)createViews {
    
    
    UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    lb.text = @"选择圈子";
    lb.font = kFont(14);
    [self.headView addSubview:lb];
    
    UIImageView * imgV =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 35, 15, 20, 20)];
    imgV.image = [UIImage imageNamed:@"more"];
    [self.headView addSubview:imgV];
    
    self.rightLB = [[UILabel alloc] initWithFrame:CGRectMake(120 , 15, ScreenW - 120 - 40 , 20)];
    [self.headView addSubview:self.rightLB];
    self.rightLB.textAlignment = NSTextAlignmentRight;
    self.rightLB.font = kFont(14);
    
    self.BT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    self.BT.tag = 12;
    [self.BT addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.BT];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 50, ScreenW-30, 0.0)];
    backV.backgroundColor = lineBackColor;
    [self.headView addSubview:backV];
    

    
    self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(backV.frame) + 10, ScreenW - 16 , 150)];
    self.TV.backgroundColor = RGB(250, 250, 250);
    self.TV.placeholder = @"说点什么吧~请注意遵守圈子规则 (圈子规则可以在我的-设置-查看圈子规则中查看)";
    self.TV.font = kFont(14);
    [self.headView addSubview:self.TV];
    
    self.huaTiView = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.TV.frame) + 15, ScreenW, 40)];
    [self.huaTiView setTitle:@"    点击请选择话题 >" forState:UIControlStateNormal];
    self.huaTiView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.huaTiView.titleLabel.font = kFont(13);
    [self.huaTiView setTitleColor:CharacterBackColor forState:UIControlStateNormal];
    [self.huaTiView addTarget:self action:@selector(goBiaoQian) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.huaTiView];
    
 
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.huaTiView.frame) + 15, ScreenW, (ScreenW - 60)/3)];
    [self.headView addSubview:self.scrollview];
    [self addPicWithArr:self.picsArr];
    
    
    self.linkV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollview.frame) + 15, ScreenW, 0)];
    self.linkV.clipsToBounds = YES;
    [self.headView addSubview:self.linkV];
    
    UIView * grayV = [[UIView alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30, 45)];
    grayV.backgroundColor = RGB(250, 250, 250);
    [self.linkV addSubview:grayV];
    
//    
//    UIButton * linkBT =[[UIButton alloc] initWithFrame:CGRectMake(5, 2.5, ScreenW - 40- 30 , 40)];
//    linkBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [linkBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    linkBT.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
//    linkBT.tag = 400;
//    [linkBT setImage:[UIImage imageNamed:@"logo2"] forState:UIControlStateNormal];
//    [grayV addSubview:linkBT];
//    [linkBT addTarget:self action:@selector(linkAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.linkBt = linkBT;
    
    UIButton * deleteBt =[UIButton buttonWithType:UIButtonTypeCustom];
    deleteBt.frame = CGRectMake(ScreenW - 30 - 20 ,-5, 25, 25);
    [deleteBt setImage:[UIImage imageNamed:@"48"] forState:UIControlStateNormal];
    deleteBt.tag = 401;
    [deleteBt addTarget:self action:@selector(linkAction:) forControlEvents:UIControlEventTouchUpInside];
    [grayV addSubview:deleteBt];
    
    
    [self.headView addSubview:self.huaTiView];
    
    
    
    
    self.desLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.linkV.frame) + 50 , ScreenW - 30, 50)];
    self.desLB.numberOfLines = 0;
    [self.headView addSubview:self.desLB];
    
    NSString * str = @"请遵守文明规范, 不准有不可描述的内容出现哦~被发现会被禁言~非会员每日最多可发五个帖子, 会员不受限制~请大家尽量不要发没有意义的内容, 共同打造和谐美好的社会文化~";
    self.desLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:5 textColor:CharacterBlack40];
    self.desLB.mj_h = [str getHeigtWithFontSize:14 lineSpace:5 width:ScreenW - 30];
    
    
    self.tiXingLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.desLB.frame) + 15 , ScreenW - 30, 0)];
    self.tiXingLB.numberOfLines = 0;
    self.tiXingLB.font = kFont(13);
    self.tiXingLB.textColor = CharacterBlackColor;
    self.tiXingLB.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapOne:)];
    [self.tiXingLB addGestureRecognizer:tap];
    
    [self.headView addSubview:self.tiXingLB];
    
    self.headView.mj_h = CGRectGetMaxY(self.tiXingLB.frame)+20;
    self.tableView.tableHeaderView = self.headView;
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 -50, ScreenW, 50)];
    if (sstatusHeight>20) {
        self.bottomView.frame = CGRectMake(0, ScreenH - sstatusHeight - 44 - 50- 34, ScreenW, 50);
    }
    [self.view addSubview:self.bottomView];
    NSArray * mmArr = @[@"57",@"12",@"28"];
    for (int i = 0 ; i < mmArr.count ; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 + 80 * i, 0, 50, 50)];
        [button setImage:[UIImage imageNamed:mmArr[i]] forState:UIControlStateNormal];
        [self.bottomView addSubview:button];
        button.tag = 300+i;
        [button addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    
}

- (void)addPicWithArr:(NSMutableArray *)picsArr {

    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    for (int i = 0 ; i < picsArr.count; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 +  ((ScreenW - 60) /3 +15 )* i , 0, (ScreenW - 60) /3, (ScreenW - 60) /3)];
        button.layer.cornerRadius = 3;
        button.tag = 100+i;
        button.clipsToBounds = YES;
        button.backgroundColor = RGB(250, 250, 250);
        [button setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:button];
        
        UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 60) /3 - 25 , 0, 25, 25)];
        [deleteBt setImage:[UIImage imageNamed:@"48"] forState:UIControlStateNormal];
        deleteBt.tag = 200+i;
        deleteBt.backgroundColor = RGB(245, 245, 245);
        [deleteBt setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
        [deleteBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:deleteBt];
        self.scrollview.contentSize = CGSizeMake(15 + (15 + (ScreenW - 60)/3) * picsArr.count, (ScreenW - 60)/3);
    }
        
    if (picsArr.count < 9) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 +  ((ScreenW - 60) /3 +15)* picsArr.count , 0, (ScreenW - 60) /3, (ScreenW - 60) /3)];
        button.layer.cornerRadius = 3;
        button.tag = 100+picsArr.count;
        button.clipsToBounds = YES;
        button.backgroundColor = RGB(245, 245, 245);
        [button setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:button];
        self.scrollview.contentSize = CGSizeMake(15 + (15 + (ScreenW - 60)/3) * (picsArr.count + 1), (ScreenW - 60)/3);
    }else {
        self.scrollview.contentSize = CGSizeMake(15 + (15 + (ScreenW - 60)/3) * picsArr.count, (ScreenW - 60)/3);
    }
    
    
}

- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * requestDict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getSysSocialCircleListURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataArray = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

//添加话题
- (void)createHuaTiVIews {
    
    
    for (int i = 0 ; i < 3; i++) {
        UIButton * button = (UIButton * )[self.huaTiView viewWithTag:100+i];
        UIButton * button1 = (UIButton * )[self.huaTiView viewWithTag:200+i];
        if (button != nil) {
            [button removeFromSuperview];
        }
        if (button1 != nil) {
            [button1 removeFromSuperview];
        }
    }
    
    if (self.huaTiArr.count > 0) {
        [self.huaTiView setTitle:@"" forState:UIControlStateNormal];
    }else {
        [self.huaTiView setTitle:@"    点击请选择话题 >" forState:UIControlStateNormal];
    }
    
    
    CGFloat XX = 15;
    CGFloat totalW = XX;
    NSInteger number = 1;
    CGFloat btH = 30;
    CGFloat spaceW = 15;
    CGFloat spaceH = 10;
    CGFloat btY0 =2.5;
    
    for (int i = 0 ; i < self.huaTiArr.count; i++) {
        UIButton * button =[UIButton new];
        // button.hidden = YES;
        button.tag = 100+i;
        [button setTitleColor:CharacterRedColor forState:UIControlStateNormal];
        button.layer.borderColor = CharacterRedColor.CGColor;
        button.layer.borderWidth = 0.8;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font =[UIFont systemFontOfSize:13];
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        NSString * str = [NSString stringWithFormat:@"%@",self.huaTiArr[i].name];
        [button setTitleColor:WhiteColor forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateSelected];
        [button setTitle:str forState:UIControlStateNormal];
        CGFloat width =[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width;
        
       
        
        button.x = totalW;
        button.y = btY0+(number-1) *(btH+spaceH);
        button.height =btH;
        button.width = width+30;
        totalW = button.x + button.width + spaceW;
        
        UIButton * closeBt = [[UIButton alloc] initWithFrame:CGRectMake(button.x + button.width - 5 , button.y - 5  , 10, 10)];
        [closeBt setImage:[UIImage imageNamed:@"101"] forState:UIControlStateNormal];
        closeBt.tag = 200+i;
        [self.huaTiView addSubview:closeBt];
        [button addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [closeBt addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.huaTiView addSubview:button];

        
        self.scrollview.mj_y = CGRectGetMaxY(self.huaTiView.frame) + 15;
        if (self.linkStr.length == 0) {
          self.desLB.mj_y = CGRectGetMaxY(self.scrollview.frame) + 15 ;
          self.tiXingLB.mj_y = CGRectGetMaxY(self.desLB.frame) + 15 ;
        }else {
          self.linkV.mj_y = CGRectGetMaxY(self.scrollview.frame) + 15 ;
          self.desLB.mj_y = CGRectGetMaxY(self.linkV.frame) + 15 ;
          self.tiXingLB.mj_y = CGRectGetMaxY(self.desLB.frame) + 15 ;
        }
        self.headView.mj_h = CGRectGetMaxY(self.tiXingLB.frame) + 20 ;
        self.tableView.tableHeaderView = self.headView;
        
    }
    
}

//添加链接
- (void)addLinkWithStr:(NSString *)str {
    
    if (str.length != 0) {
        [self.linkBt setTitle:str forState:UIControlStateNormal];
        self.linkV.mj_h = 55;
        self.linkV.mj_y = CGRectGetMaxY(self.scrollview.frame) + 10;
        self.desLB.mj_y = CGRectGetMaxY(self.linkV.frame) + 15;
        self.headView.mj_h = CGRectGetMaxY(self.desLB.frame) + 20;
        
    }else {
        self.linkStr = @"";
        self.linkV.mj_h = 0;
        self.desLB.mj_y = CGRectGetMaxY(self.scrollview.frame) + 15;
        self.headView.mj_h = CGRectGetMaxY(self.desLB.frame) + 20;
    }
    
    
}

//点击link
- (void)linkAction:(UIButton *)button {
    if (button.tag == 400) {
        //
    }else {
        [self addLinkWithStr:@""];
    }
    
    
}

//点击图片
- (void)clickAction:(UIButton *)button {
    
    if (button.tag >=200) {
        [self.picsArr removeObjectAtIndex:button.tag - 200];
        [self addPicWithArr:self.picsArr];
    }else {
        if (button.tag - 100  == self.picsArr.count) {
            
            [self addPict];
            
        }
    }
}

//点击下面的按钮
- (void)bottomAction:(UIButton *)button {
    if (button.tag == 300) {
        if (self.picsArr.count == 9) {
            [SVProgressHUD showErrorWithStatus:@"图片已经到最大张数了"];
            return;
        }
        [self addPict];
        
    }else if (button.tag == 301) {
        [self tapOne:nil];
        
    }else if (button.tag == 302) {
        [self goBiaoQian];
    }else {
        Weak(weakSelf);
        QQYYAddLinkVC * vc =[[QQYYAddLinkVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.linkBlock = ^(NSString * _Nonnull linkStr) {
            weakSelf.linkStr = linkStr;
            [weakSelf addLinkWithStr:linkStr];

        };
        [self.navigationController pushViewController:vc animated:YES];
        
      
    }
    
}

- (void)tapOne:(UITapGestureRecognizer *)tap {
    
    //@人员
    QQYYTongXunLuTVC * vc =[[QQYYTongXunLuTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.arr = [self.idStr componentsSeparatedByString:@","];
    Weak(weakSelf);
    vc.sendFriendsBlock = ^(NSString * _Nonnull nickNameStr, NSString * _Nonnull idStr) {
        weakSelf.idStr = idStr;
        weakSelf.nickNameStr = nickNameStr;
        
        weakSelf.tiXingLB.mj_h = [[NSString stringWithFormat:@"提醒谁看:%@",nickNameStr] getHeigtWithFontSize:13 lineSpace:3 width:ScreenW - 30];
        weakSelf.tiXingLB.attributedText = [[NSString stringWithFormat:@"提醒谁看:%@",nickNameStr] getMutableAttributeStringWithFont:13 lineSpace:3 textColor:CharacterBlackColor];
        weakSelf.headView.mj_h = CGRectGetMaxY(weakSelf.tiXingLB.frame) + 20;
        weakSelf.tableView.tableHeaderView = weakSelf.headView;
        
        //            if (weakSelf.nickNameStr.length > 0) {
        //                NSString * str = [NSString stringWithFormat:@"@%@ ",weakSelf.nickNameStr];
        //                weakSelf.TV.text = [weakSelf.TV.text substringWithRange:NSMakeRange(str.length, weakSelf.TV.text.length - str.length)];
        //            }
        //
        //            weakSelf.nickNameStr = nickNameStr;
        //            if (nickNameStr.length > 0) {
        //            weakSelf.TV.text = [NSString stringWithFormat:@"@%@ %@",nickNameStr,weakSelf.TV.text];
        //            }
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)closeAction:(UIButton *)button {
    
    if (button.tag >=200) {
      [self.huaTiArr removeObjectAtIndex:button.tag-200];
    }else {
       [self.huaTiArr removeObjectAtIndex:button.tag-100];
    }
    [self createHuaTiVIews];
    
}

- (void)goBiaoQian {
    
    QQYYHuaTiTVC * vc =[[QQYYHuaTiTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    __weak typeof(self) weakSelf = self;
    vc.htBlock = ^(NSArray *arr) {
        weakSelf.huaTiArr = arr.mutableCopy;
        [weakSelf createHuaTiVIews];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.picsArr addObject:image];
                [self addPicWithArr:self.picsArr];
            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
      
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-self.picsArr.count columnNumber:4 delegate:self pushPhotoPickerVc:YES];
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                [self.picsArr addObjectsFromArray:photos];
               
                [self addPicWithArr:self.picsArr];
                
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}

//点击发布
- (void)leftOrRightClickAction:(UIButton *)button {
    if (button.tag == 11) {
        
        [self faBuAction:button];
        
        
    }else if (button.tag == 12) {
      
//        QQYYQuanZiGuiZeListTVC * vc =[[QQYYQuanZiGuiZeListTVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        __weak typeof(self) weakSelf = self;
//        vc.typeBlock = ^(NSString * _Nonnull ID, NSString * _Nonnull name) {
//            weakSelf.rightLB.text = weakSelf.circleName =  name;
//            weakSelf.circleID = ID;
//        };
//        vc.isFaTie = YES;
//        [self.navigationController pushViewController:vc animated:YES];

        [self.TV resignFirstResponder];
        self.showView.dataArray = self.dataArray;
        [self.showView show];
        
        
    }
    
    
}


- (void)didClickIndex:(NSInteger)index {
    
    
}

- (void)didSelctStr:(NSString *)str idStr:(NSString *)idStr {
    
    self.rightLB.text = self.circleName =  str;
    self.circleID = idStr;
    
}

- (void)faBuAction:(UIButton *)button {

    if (!self.circleID) {
        [SVProgressHUD showErrorWithStatus:@"请选择圈子"];
        return;
    }
    if (self.TV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    if (self.huaTiArr.count == 0) {
        
        QQYYHuaTiTVC * vc =[[QQYYHuaTiTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        __weak typeof(self) weakSelf = self;
        vc.htBlock = ^(NSArray *arr) {
            weakSelf.huaTiArr = arr.mutableCopy;
            [weakSelf createHuaTiVIews];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
        
    }
    Weak(weakSelf);
    if (self.picsArr.count > 0) {
        [zkRequestTool uploadImagsWithArr:self.picsArr withType:@"5" result:^(NSString *str) {
            [weakSelf sendTwoWithButton:button withStr:str];
        }];
        
    }else {
        [self sendTwoWithButton:button withStr:nil];
    }
}


- (void)sendTwoWithButton:(UIButton *)button withStr:(NSString * )picStr{
    


    NSMutableDictionary * requestDict = @{}.mutableCopy;
    requestDict[@"circleId"] = self.circleID;
    requestDict[@"circleName"] = self.circleName;
    requestDict[@"content"] = [NSString emojiConvert:self.TV.text];
    
//    if (self.nickNameStr.length > 0) {
//        NSString * str = [NSString stringWithFormat:@"@%@ ",self.nickNameStr];
//        NSString * contentStr = [self.TV.text substringWithRange:NSMakeRange(str.length, self.TV.text.length - str.length)];
//        if (contentStr.length == 0) {
//            [SVProgressHUD showErrorWithStatus:@"请输入发帖内容!"];
//            return;
//        }
//        requestDict[@"content"] = contentStr;
//
//    }
    
    requestDict[@"atUserId"] = self.idStr;
    if (picStr) {
        requestDict[@"pic"] = picStr;
    }
    if (self.linkStr) {
        requestDict[@"linkUrl"] = self.linkStr;
    }
    NSMutableArray * arr = @[].mutableCopy;
    for (QQYYTongYongModel * model  in self.huaTiArr) {
        [arr addObject:model.ID];
    }
    requestDict[@"tagId"] = [arr componentsJoinedByString:@","];
    button.userInteractionEnabled = NO;
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getaddURL] parameters:requestDict success:^(NSURLSessionDataTask *task, id responseObject) {
        button.userInteractionEnabled = YES;
        if ([responseObject[@"code"] intValue]== 0) {
            
            [SVProgressHUD showSuccessWithStatus:@"发帖成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        button.userInteractionEnabled = YES;
        
    }];
    
    
}

@end
