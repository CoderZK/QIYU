//
//  QQYYDetailTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYDetailTVC.h"
#import "QQYYDongTaiDetailCell.h"
#import "QQYYDetailTVC.h"
#import "QQYYDetailZanCell.h"
#import "QQYYDetailPingLunCell.h"
#import "QQYYPingLunTwoCell.h"
#import "QQYYGuanZhuHeadTVC.h"
#import "zkJuBaoView.h"
#import "QQYYReDuTVC.h"
#import "QQYYJuBaoVC.h"
#import "CustomEmojiView.h"
#import "WZCustomEmojiView.h"
@interface QQYYDetailTVC ()<UITextFieldDelegate,QQYYDetailZanCellDelegate,zkJuBaoViewDelegate,QQYYDongTaiDetailCellDelegate,QQYYYongBaoViewDeletage,CustomEmojiDelegate,WZCustomEmojiDelegate,UITextViewDelegate>
@property(nonatomic,strong)zkHomelModel *dataModel;
@property(nonatomic,strong)UIView *pingLunV;
//@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,strong)UIButton *sendBt,*emoBt;
@property(nonatomic,strong)QQYYYongBaoView *showView;
@property(nonatomic,strong)NSIndexPath *selectIndexPath;
@property(nonatomic,assign)BOOL isPingTie;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)CustomEmojiView *emojiView;
@property(nonatomic, strong) WZCustomEmojiView *emojiKeyboard;
@property(nonatomic,strong)UITextView *TV1,*TV2;


@end

@implementation QQYYDetailTVC

- (WZCustomEmojiView *)emojiKeyboard {
    if (!_emojiKeyboard) {
        _emojiKeyboard = [[WZCustomEmojiView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 250, CGRectGetWidth(self.view.frame), 250)];
        _emojiKeyboard.delegate = self;
        //        _emojiKeyboard.insertTF = self.inserTF;
    }
    return _emojiKeyboard;
}

- (CustomEmojiView *)emojiView {
    if (_emojiView == nil) {
        _emojiView = [[CustomEmojiView alloc] initWithFrame:CGRectMake(0, ScreenH - 240, ScreenW, 240)];
    }
    _emojiView.delegate = self;
    return _emojiView;
}

- (QQYYYongBaoView *)showView {
    if (_showView == nil) {
        _showView = [[QQYYYongBaoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _showView.deletage = self;
    }
    return _showView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.sendZanYesOrNoBlock != nil) {
        self.sendZanYesOrNoBlock(self.dataModel.currentUserLike, self.dataModel.likeNum);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    self.isPingTie = YES;
    
    [self.tableView registerClass:[QQYYDongTaiDetailCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[QQYYDetailZanCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[QQYYDetailPingLunCell class] forCellReuseIdentifier:@"cell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QQYYPingLunTwoCell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    self.tableView.estimatedRowHeight = 0.1;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _dataModel = [[zkHomelModel alloc] init];
//    _dataModel.content = @"安排发GIF个疯女人废粉盒呢哇我来啊约啊hi而不能发给你分为hiUR个安排发GIF个疯女人废粉盒呢哇我来啊约啊hi而不能发给你分为hiUR个安排发GIF个疯女人废粉盒呢哇我来啊约啊hi而不能发给你分为hiUR个安排发GIF个疯女人废粉盒呢哇我来啊约啊hi而不能发给你分为hiUR个";
    self.pingLunV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 50 - sstatusHeight - 44 , ScreenW, 50)];
    self.pingLunV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pingLunV];
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 50);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 50-34);
        self.pingLunV.frame = CGRectMake(0, ScreenH - 50 - sstatusHeight - 44 -34 , ScreenW, 50);
    }
    [self setpingLunV];
    
    
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    
    UIButton * rightbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"sandian"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.tag = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
    [self getData];
    self.pageNo = 1;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self getData];
    }];

    //评论更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self getPingLun];
        
    }];
    
    
}

- (void)navBtnClick:(UIButton *)button {
    
    if  (self.dataModel.currentUserCollect) {
        [zkJuBaoView showWithArray:@[@"举报",@"取消收藏"] withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }else {
        [zkJuBaoView showWithArray:@[@"举报",@"收藏"] withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    

    [zkJuBaoView shareInstance].delegate = self;
 
}

- (void)getData {

    [zkRequestTool networkingPOST:[QQYYURLDefineTool getdetailURL] parameters:self.ID success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.dataModel = [zkHomelModel mj_objectWithKeyValues:responseObject[@"object"]];
            [self.tableView reloadData];
            self.pageNo = 1;
            [self getPingLun];
        }else {
            
            if ([responseObject[@"code"] intValue]== 10004) {
                [SVProgressHUD showSuccessWithStatus:@"帖子已被删除"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)getPingLun {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"postId"] = self.ID;
    dict[@"pageNo"] = @(self.pageNo);
    dict[@"pageSize"] = @(10);
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getReplyPageListForPostURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            NSArray * arr = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
            if (self.pageNo == 1) {
                [self.dataModel.replyInfoVoList removeAllObjects];
            }
            [self.dataModel.replyInfoVoList addObjectsFromArray:arr];
            
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:(UITableViewRowAnimationNone)];
            [self.tableView reloadData];
            
            self.pageNo++;
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)setpingLunV {
    
//    self.TF = [[UITextField alloc] initWithFrame:CGRectMake(10, 7.5, ScreenW - 20 - 75 - 50 , 35)];
//    self.TF.backgroundColor = RGB(245, 245, 245);
//    self.TF.font = kFont(14);
//    self.TF.delegate = self;
////    self.TF.inputView = self.emojiKeyboard;
//    self.TF.returnKeyType = UIReturnKeySend;
//    [self.pingLunV addSubview:self.TF];
    
    self.TV1 = [[UITextView alloc] initWithFrame:CGRectMake(10, 7.5, ScreenW - 20 - 75 - 50 , 35)];
    self.TV1.userInteractionEnabled = NO;
    self.TV1.textColor = CharacterBackColor;
    [self.pingLunV addSubview:self.TV1];
    
    
    self.TV2 = [[UITextView alloc] initWithFrame:CGRectMake(10, 7.5, ScreenW - 20 - 75 - 50 , 35)];
    self.TV2.backgroundColor =[UIColor clearColor];
    self.TV2.keyboardType = UIReturnKeySend;
    self.TV2.layer.borderWidth = 0.5f;
    self.TV2.layer.cornerRadius = 5;
    self.TV2.clipsToBounds = YES;
    self.TV2.layer.borderColor = CharacterBackColor.CGColor;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapOne:)];
    [self.TV2 addGestureRecognizer:tap];
    
    
    self.TV2.textColor = CharacterBlackColor;
    self.TV2.delegate = self;
    [self.pingLunV addSubview:self.TV2];
    
    self.emoBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 75 - 45 , 7.5, 35, 35)];
    [self.emoBt setBackgroundImage:[UIImage imageNamed:@"97"] forState:UIControlStateNormal];
    [self.emoBt setBackgroundImage:[UIImage imageNamed:@"98"] forState:UIControlStateSelected];
    [self.emoBt addTarget:self action:@selector(emoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.pingLunV addSubview:self.emoBt];
    
    self.sendBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 75, 7.5, 60, 35)];
    [self.sendBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    [self.sendBt setTitle:@"发送" forState:UIControlStateNormal];
    self.sendBt.titleLabel.font = kFont(14);
    [self.sendBt addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.pingLunV addSubview:self.sendBt];
    
    self.sendBt.layer.cornerRadius = 3;
    self.sendBt.clipsToBounds = YES;
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataModel == nil) {
        return 0;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        if (self.dataModel.postLikeVoList.count == 0) {
            return 0;
        }
        return 1;
    }
    return self.dataModel.replyInfoVoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return self.dataModel.cellHeight;
    }else if (indexPath.section == 1) {
        return 65;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        QQYYDongTaiDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.isDetail = YES;
        cell.delegate = self;
        cell.model = self.dataModel;
        return cell;
    }else if (indexPath.section == 1) {
        QQYYDetailZanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        [cell.moreBt addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        cell.dataArrayTwo = self.dataModel.postLikeVoList;
        cell.delegate = self;
        return cell;
    }else {
        
        QQYYPingLunTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        zkHomelModel * model = self.dataModel.replyInfoVoList[indexPath.row];
        cell.nameLB.text = model.replyUserNickName;
        cell.timeLB.text = [NSString stringWithTime:model.createTime];
        cell.timeLB.mj_w = [[NSString stringWithFormat:@"%@ %@",model.city,[NSString stringWithTime:model.createTime]] getWidhtWithFontSize:13];
        if (model.replyId.length == 0) {
            //回复帖子
           cell.contentLB.text = [NSString emojiRecovery:model.content];
        }else {
            //回复评论
            NSString * str = [NSString stringWithFormat:@"回复%@: %@",model.blogUserNickName,[NSString emojiRecovery:model.content]];
            cell.contentLB.attributedText = [str getMutableAttributeStringWithFont:13 lineSpace:3 textColor:CharacterBlackColor textColorTwo:CharacterBackColor nsrange:NSMakeRange(0, 2)];
        }
        [cell.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QQYYURLDefineTool getImgURLWithStr:model.replyUserAvatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 0.01;
    }else {
        if (section == 1 && self.dataModel.postLikeVoList.count == 0) {
            return 0.01;
        }
        return 10;
    }
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        [self moreAction];
    }else if (indexPath.section == 2) {
        self.selectIndexPath = indexPath;
        self.isPingTie = NO;
        zkHomelModel * model = self.dataModel.replyInfoVoList[indexPath.row];
        self.TV1.text = [NSString stringWithFormat:@"回复: %@",model.replyUserNickName];
        [self.TV2 becomeFirstResponder];
    }else if (indexPath.section == 0) {
        self.selectIndexPath = indexPath;
        self.isPingTie = YES;
        [self.TV2 becomeFirstResponder];
    }
    
}

- (void)moreAction {
    QQYYGuanZhuHeadTVC * vc =[[QQYYGuanZhuHeadTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.dataArray = self.dataModel.postLikeVoList;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
   
}
- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.isPingTie = YES;
    self.emoBt.selected = NO;
}

#pragma mark ---- 点击表情键盘事件 ---

- (void)didClickEmojiLabel:(NSString*)emojiStr {
    
    self.TV2.text = [self.TV2.text stringByAppendingString:emojiStr];
    if (self.TV2.text.length > 0) {
        self.TV1.hidden = YES;
    }else {
        self.TV1.hidden = NO;
    }

}



- (void)didClickDeleteButton:(FICustomEmojiView *)stickerKeyboard {
    NSRange selectedRange = self.TV2.selectedRange;
    if (selectedRange.location == 0 && selectedRange.length == 0) {
        return;
    }

    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.TV2.attributedText];
    if (selectedRange.length > 0) {
        [attributedText deleteCharactersInRange:selectedRange];
        self.TV2.text = [attributedText string];
        self.TV2.selectedRange = NSMakeRange(selectedRange.location, 0);
    } else {
        NSUInteger deleteCharactersCount = 1;

        // 下面这段正则匹配是用来匹配文本中的所有系统自带的 emoji 表情，以确认删除按钮将要删除的是否是 emoji。这个正则匹配可以匹配绝大部分的 emoji，得到该 emoji 的正确的 length 值；不过会将某些 combined emoji（如 👨‍👩‍👧‍👦 👨‍👩‍👧‍👦 👨‍👨‍👧‍👧），这种几个 emoji 拼在一起的 combined emoji 则会被匹配成几个个体，删除时会把 combine emoji 拆成个体。瑕不掩瑜，大部分情况下表现正确，至少也不会出现删除 emoji 时崩溃的问题了。
        NSString *emojiPattern1 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900-\\U0001F9FF]";
        NSString *emojiPattern2 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900–\\U0001F9FF]\\uFE0F";
        NSString *emojiPattern3 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900–\\U0001F9FF][\\U0001F3FB-\\U0001F3FF]";
        NSString *emojiPattern4 = @"[\\rU0001F1E6-\\U0001F1FF][\\U0001F1E6-\\U0001F1FF]";
        NSString *pattern = [[NSString alloc] initWithFormat:@"%@|%@|%@|%@", emojiPattern4, emojiPattern3, emojiPattern2, emojiPattern1];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:kNilOptions error:NULL];
        NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:attributedText.string options:kNilOptions range:NSMakeRange(0, attributedText.string.length)];
        for (NSTextCheckingResult *match in matches) {
            if (match.range.location + match.range.length == selectedRange.location) {
                deleteCharactersCount = match.range.length;
                break;
            }
        }

        [attributedText deleteCharactersInRange:NSMakeRange(selectedRange.location - deleteCharactersCount, deleteCharactersCount)];
        self.TV2.text = [attributedText string];
        self.TV2.selectedRange = NSMakeRange(selectedRange.location - deleteCharactersCount, 0);
    }
    
    if (self.TV2.text.length > 0) {
        self.TV1.hidden = YES;
    }else {
        self.TV1.hidden = NO;
    }

}


//点击emoqiehu
- (void)emoAction:(UIButton *)button {
    button.selected = !button.selected;
    [self.TV2 becomeFirstResponder];
    if (button.selected) {
        self.TV2.inputView = self.emojiKeyboard;
    }else {
        self.TV2.inputView = nil;
    }
    [self.TV2 reloadInputViews];
    
}

//点击textView
- (void)tapOne:(UITapGestureRecognizer *)tap {
    
    [self.TV2 becomeFirstResponder];
    self.TV2.inputView = nil;
    self.emoBt.selected = NO;
    [self.TV2 reloadInputViews];
   
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self replyAction];
    return YES;
}

//点击发送
- (void)sendAction :(UIButton *)button {
    [self replyAction];

}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length > 0) {
        self.TV1.hidden = YES;
    }else {
        self.TV1.hidden = NO;
    }
    
}

- (void)replyAction{
    
    if (self.TV2.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"postId"] = self.ID;
    dict[@"content"] = [NSString emojiConvert:self.TV2.text];
    if (!self.isPingTie) {
        dict[@"replyId"] = self.dataModel.replyInfoVoList[self.selectIndexPath.row].ID;
    }
    [zkRequestTool networkingPOST:[QQYYURLDefineTool getreplyURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            zkHomelModel * model = [zkHomelModel mj_objectWithKeyValues:responseObject[@"object"]];
            [self.dataModel.replyInfoVoList insertObject:model atIndex:0];
            self.dataModel.replyNum++;
//            self.isPingTie = YES;
            self.TV1.text = @"";
            self.TV2.text = @"";
            [self.TV2 resignFirstResponder];
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:(UITableViewRowAnimationAutomatic)];
             [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}




#pragma mark ----- 点击收藏或者举报 -----
- (void)didSelectAtIndex:(NSInteger )index withIndexPath:(NSIndexPath *)indexPath {
    
    if (index == 1) {
        //收藏
        [self collectionWithModel:self.dataModel WithIndePath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }else {
        //举报
        QQYYJuBaoVC * vc =[[QQYYJuBaoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.ID;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
    
}

#pragma mark ----- 点击了点赞人的头像  -----
- (void)didClickZanHeadBtWithIndex:(NSInteger)index{
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    
    QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataModel.postLikeVoList[index].createBy;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


#pragma mark ------ 点击cell 内部的按钮 ----
//0 头像 1 查看,2 评论 3 赞 ,4送花,5分享 6 点击查看原文
-(void)didClickButtonWithCell:(QQYYDongTaiDetailCell *)cell andIndex:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (index == 0) {
        QQYYZhuYeTVC * vc =[[QQYYZhuYeTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userId = self.dataModel.createBy;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1) {
        
    }else if (index == 2) {
        
    }else if (index == 3) {
        [self zanActionWithModel:self.dataModel WithIndePath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }else if (index == 4) {
        
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        if ([[zkSignleTool shareTool].session_uid isEqualToString:self.dataModel.createBy]) {
            [SVProgressHUD showErrorWithStatus:@"自己不能给自己送爱豆"];
            return;
        }
        [self.showView showWithIndexPath:indexPath];
        
    }else if (index == 5) {
        
        [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)] withUrl:@"123" shareModel:nil];
        
    }else if (index == 6) {
       
    }else if (index == 7) {
        
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self collectionWithModel:self.dataModel WithIndePath:indexPath];
    }
    
    
    
    
}

//收藏或者取消操作
- (void)collectionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"targetId"] = model.postId;
    dict[@"type"] = @"2";
    NSString * url = [QQYYURLDefineTool addMyCollectionURL];
    if (model.currentUserCollect) {
        url = [QQYYURLDefineTool deleteMyCollectionURL];
        [zkRequestTool networkingPOST:url parameters:model.postId success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (model.currentUserCollect) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
                }
                model.currentUserCollect = !model.currentUserCollect;
                [self.tableView reloadData];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }else {
        [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (model.currentUserCollect) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
                }
                model.currentUserCollect = !model.currentUserCollect;
                [self.tableView reloadData];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }
    
    
    
}


- (void)zanActionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    

    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"postId"] = model.postId;
    dict[@"type"] = @"1";
    NSString * url = [QQYYURLDefineTool getlikeURL];
    if (model.currentUserLike) {
        url = [QQYYURLDefineTool notlikeURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            model.currentUserLike = !model.currentUserLike;
            if (model.currentUserLike) {
                model.likeNum = model.likeNum + 1;
                zkHomelModel * modelNei = [[zkHomelModel alloc] init];
                modelNei.avatar = [zkSignleTool shareTool].img;
                modelNei.nickName = [zkSignleTool shareTool].nickName;
                modelNei.createBy = [zkSignleTool shareTool].session_uid;
                [self.dataModel.postLikeVoList insertObject:modelNei atIndex:0];
            }else {
                model.likeNum = model.likeNum - 1;
                
                for (zkHomelModel * zanModel  in self.dataModel.postLikeVoList) {
                    if ([zanModel.createBy isEqualToString:[zkSignleTool shareTool].session_uid]) {
                        [self.dataModel.postLikeVoList removeObject:zanModel];
                        break;
                    }
                }
                
            }
            
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


#pragma  mark ---- 点击 抱一抱 的内容 ----
- (void)didClcikIndex:(NSInteger)index withIndexPath:(NSIndexPath *)indexPath WithNumber:(nonnull NSString *)str{
    
    if (index == 4) {
        [self.showView diss];
        QQYYReDuTVC * vc =[[QQYYReDuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        Weak(weakSelf);
        [self sendFlowerWithNumber:str andLinkId:self.dataModel.postId andIsGiveUser:NO result:^(BOOL isOK) {
            if (isOK) {
                [SVProgressHUD showSuccessWithStatus:@"送爱豆成功!"];
                [weakSelf.tableView reloadData];
            }
            
            
        }];
    }
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
