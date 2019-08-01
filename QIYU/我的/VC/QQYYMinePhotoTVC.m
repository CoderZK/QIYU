//
//  QQYYMinePhotoTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYMinePhotoTVC.h"
#import "QQYYPhotoCell.h"
@interface QQYYMinePhotoTVC ()<TZImagePickerControllerDelegate,UINavigationBarDelegate,QQYYPhotoCellDelegate>
@property(nonatomic,strong)UIView *headV,*footV;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *imgsArr;
@property(nonatomic,strong)UIButton *rightBt;
@property(nonatomic,assign)BOOL isBianJi;


@end

@implementation QQYYMinePhotoTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.sendPhotosBlock != nil) {
        self.sendPhotosBlock(self.photos);
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.navigationItem.title = @"我的相册";
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 100);
    [self.tableView registerClass:[QQYYPhotoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 100 - sstatusHeight - 44 , ScreenW, 100)];
    self.footV.backgroundColor = WhiteColor;;
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30, 100)];
    lb.numberOfLines = 0;
    lb.attributedText = [@"提示：非会员最多可上传10张图片，会员可以上传20张。上传的图片将由工作人员审核，审核通过后方可出现在个人相册中。审核时间为工作日10：00-18：00" getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlack40];
    [lb sizeToFit];

    lb.mj_y = 50 -lb.mj_h/2;
    [self.footV addSubview:lb];
    
    [self.view addSubview:self.footV];
    
    UIButton * rightbtn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 45 - 15,  sstatusHeight + 2,45, 40)];
    [rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
    rightbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightbtn.titleLabel.font = kFont(14);
    [rightbtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.tag = 11;
    [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.rightBt = rightbtn;
    
    self.dataArray = @[].mutableCopy;
    self.imgsArr = @[].mutableCopy;
    if (self.photos.length > 0) {
        self.dataArray = [self.photos componentsSeparatedByString:@","].mutableCopy;
    }else {
        [self navBtnClick:rightbtn];
    }

//    self.dataArray =  @[@"http://i0.hdslb.com/bfs/article/3fea53d61f069aa72c71330fc229e075c5b3c1b4.jpg",@"http://5b0988e595225.cdn.sohucs.com/images/20190417/478c8d1c31c74273a504f2335b371591.jpeg",@"http://5b0988e595225.cdn.sohucs.com/images/20190404/a30336a6914b4929994450b9941afa40.jpeg",@"http://p0.qhimgs4.com/t01d406e56973481579.jpg",@"http://5b0988e595225.cdn.sohucs.com/images/20190508/a3df05de51954e2891f829380af31754.jpeg",@"http://5b0988e595225.cdn.sohucs.com/images/20190507/2e2a6a6e43304433bd7a558292fcb487.jpeg",@"http://b-ssl.duitang.com/uploads/item/201804/06/20180406212446_mclnu.jpg"].mutableCopy;
    

}

- (void)navBtnClick:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"编辑"]) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
        self.isBianJi = YES;
        [self.dataArray addObject:@""];
     
        [self.tableView reloadData];
    }else {
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        self.isBianJi = NO;
        [self.dataArray removeLastObject];
        [self updatePhotos];
        [self.tableView reloadData];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return (self.dataArray.count % 3) == 0 ? self.dataArray.count /3 : self.dataArray.count /3 + 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenW - 60 )/3 + 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYPhotoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.isDelect = self.isBianJi;
    cell.dataArray = self.dataArray.count > 3 * (indexPath.row + 1)  ? [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 3, 3)] :[self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 3, self.dataArray.count - indexPath.row * 3)];
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma  mark -------- 点击了cell 内部的信息 -----
- (void)didClickView:(QQYYPhotoCell *)cell isDelect:(BOOL)isDelect andIsAdd:(BOOL)isAdd withIndex:(NSInteger)index {
    
     NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (isAdd) {
        //点击添加图片
        [self addPict];
    }else {
        if (isDelect) {
         //删除
            [self.dataArray removeObjectAtIndex:indexPath.row * 3 + index];
            [self.tableView reloadData];
        }else {
           //查看
            [[zkPhotoShowVC alloc] initWithArray:self.dataArray index:indexPath.row * 3 + index];
            
        }
    }
    
    
    
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            
            if (self.dataArray.count == self.maxPhotos+1) {
                
            }
            
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.dataArray insertObject:image atIndex:self.dataArray.count - 1];
                [self.tableView reloadData];
                
//                _img = image;
//                _iconImg.image = image;
                
            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxPhotos+1-self.dataArray.count columnNumber:4 delegate:self pushPhotoPickerVc:YES];
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//                _img = photos.firstObject;
//                _iconImg.image = photos.firstObject;
                [self.dataArray removeLastObject];
                [self.dataArray addObjectsFromArray:photos];
                [self.dataArray addObject:@""];
                [self.tableView reloadData];
                
                
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


- (void)updatePhotos {
    
    NSMutableArray * arr = @[].mutableCopy;
    NSMutableArray * photos = @[].mutableCopy;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        
        NSObject * object = self.dataArray[i];
        if ([object isKindOfClass:[UIImage class]]) {
            [arr addObject:object];
        }else {
            [photos addObject:object];
        }
    }
    
    if (arr.count > 0) {
        Weak(weakSelf);
        [zkRequestTool uploadImagsWithArr:arr withType:@"3" result:^(NSString *str) {
            if (photos.count > 0) {
                NSString * strtwo = [NSString stringWithFormat:@"%@,%@",[photos componentsJoinedByString:@","],str];
                [weakSelf gengXinPhotosWithString:strtwo];
                
            }else {
                [weakSelf gengXinPhotosWithString:str];
            }
        }];
    }else {
        [self gengXinPhotosWithString:[photos componentsJoinedByString:@","]];
    }
}

- (void)gengXinPhotosWithString:(NSString *)str {
    
    self.photos = str;

    if (str.length == 0) {
        str = @"123456";//删除时用
    }
    [zkRequestTool networkingPOST:[QQYYURLDefineTool uploadPhotoURL] parameters:str success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            if (self.photos.length == 0) {
                [self navBtnClick:self.rightBt];
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

@end
