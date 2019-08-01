//
//  zkDanLiaoVC.m
//  weekend
//
//  Created by kunzhang on 17/1/22.
//  Copyright © 2017年 李炎. All rights reserved.
//

#import "zkDanLiaoVC.h"
#import "QQYYQunSettingTVC.h"
//#import "zkMineActionDetaliVC.h"
//#import "LxmHomeModel.h"


@interface zkDanLiaoVC ()<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource,EMChatToolbarDelegate,EaseChatBarMoreViewDelegate,UIScrollViewDelegate>
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    UIMenuItem *_transpondMenuItem;
    
    
    
}

/** 数据字典 */
@property(nonatomic , strong)NSDictionary *dict;
/** 最后一条数据 */
@property(nonatomic , copy)NSString * lastText;
@property(nonatomic , assign)BOOL isBaoMing;


@end

@implementation zkDanLiaoVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self updateLastMessage];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = BackgroundColor;

    UIButton * rightBt =[UIButton new];
    rightBt.titleLabel.font =[UIFont systemFontOfSize:14];
    rightBt.frame = CGRectMake(0, 0, 40, 40);
//    [rightBt setTitle:@"删除" forState:UIControlStateNormal];
    [rightBt setImage:[UIImage imageNamed:@"24"] forState:UIControlStateNormal];
    [rightBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(deleteAllMessage) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = self.otherName;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBt];
    self.delegate = self;
    self.dataSource = self;
    
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
   
    [self.chatBarMoreView removeItematIndex:3];
    [self.chatBarMoreView removeItematIndex:3];
    self.lastText = @"";

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qy32"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    

}

//-(void)initNav
//{
//
//    CGFloat navH = 44;
//
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, sstatusHeight + navH )];
//    imgView.image = [UIImage imageNamed:@"bg_1"];
//    imgView.userInteractionEnabled = YES;
//    [self.view addSubview:imgView];
//
//    UIButton * leftBt =[UIButton new];
//    leftBt.titleLabel.font =[UIFont systemFontOfSize:14];
//    [leftBt setTitle:@"返回" forState:UIControlStateNormal];
//    [leftBt sizeToFit];
//    [leftBt setTitleColor:CharacterGrayColor forState:UIControlStateNormal];
//    [leftBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    leftBt.frame = CGRectMake(10, sstatusHeight + 6, 40, 30);
//    [self.view addSubview:leftBt];
//
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW-200)/2, sstatusHeight, 200, navH)];
//    title.text = @"小记者";
//    title.font = [UIFont systemFontOfSize:18];
//    title.textColor = [UIColor whiteColor];
//    title.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:title];
////    self.navigationItem.title = @"小记者";
//
//
//
//
//    UIButton * rightBt =[UIButton new];
//    rightBt.titleLabel.font =[UIFont systemFontOfSize:14];
//    [rightBt setTitle:@"删除" forState:UIControlStateNormal];
//    [rightBt sizeToFit];
//    [rightBt setTitleColor:CharacterGrayColor forState:UIControlStateNormal];
//    [rightBt addTarget:self action:@selector(deleteAllMessage) forControlEvents:UIControlEventTouchUpInside];
//    rightBt.frame = CGRectMake(ScreenW - 40-10, sstatusHeight + 6, 40, 30);
//   [self.view addSubview:rightBt];
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:right1];


//}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)tap {
    self.navigationItem.title = @"";
//    LYHomeModel * model =[[LYHomeModel alloc] init];
//    model.ID = self.dict[@"activityId"];
//    zkMineActionDetaliVC * vc = [[zkMineActionDetaliVC alloc] init];
//    vc.model = model;
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}



//离开的时候吧信息发给服务器
- (void)updateLastMessage {
    

    if (self.lastText.length == 0) {
        return;
    }
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"friendId"] = self.otherId;
    dict[@"userId"] = [zkSignleTool shareTool].session_uid;
    dict[@"charType"] = @(1);
    dict[@"chatContent"] = [NSString emojiConvert:self.lastText];
    [zkRequestTool networkingPOST:[QQYYURLDefineTool uploadUserChatRecordURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            
        }else {
           
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}



- (void)deleteAllMessage {
    
    QQYYQunSettingTVC * vc =[[QQYYQunSettingTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegateSignl = [RACSubject subject];
    [vc.delegateSignl subscribeNext:^(id  _Nullable x) {
       
        [self.conversation deleteAllMessages:nil];
        [self.messsagesSource removeAllObjects];
        [self.dataArray removeAllObjects];

        self.lastText = @"  ";
        [self.tableView reloadData];
        
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
    
//    UIAlertController * alertVC =[UIAlertController alertControllerWithTitle:nil message:@"是否删除聊天记录" preferredStyle:(UIAlertControllerStyleAlert)] ;
//    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        [self.conversation deleteAllMessages:nil];
//        [self.messsagesSource removeAllObjects];
//        [self.dataArray removeAllObjects];
//
//        self.lastText = @"  ";
//        [self.tableView reloadData];
//
//    }];
//    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alertVC addAction:action1];
//    [alertVC addAction:action2];
//    [self presentViewController:alertVC animated:YES completion:nil];

}

//长按收拾回调样例：
- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    //样例给出的逻辑是所有cell都允许长按
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    //样例给出的逻辑是长按cell之后显示menu视图
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return NO;
}

- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType
{
    if (self.menuController == nil) {
        self.menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"删除", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"复制", @"Copy") action:@selector(copyMenuAction:)];
    }
    
    if (_transpondMenuItem == nil) {
        _transpondMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"转发", @"Transpond") action:@selector(transpondMenuAction:)];
    }
    
    if (messageType == EMMessageBodyTypeText) {
        [self.menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem,_transpondMenuItem]];
    } else if (messageType == EMMessageBodyTypeImage){
        [self.menuController setMenuItems:@[_deleteMenuItem,_transpondMenuItem]];
    } else {
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    }
    [self.menuController setTargetRect:showInView.frame inView:showInView.superview];
    [self.menuController setMenuVisible:YES animated:YES];
}



- (void)transpondMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
   
    }
    self.menuIndexPath = nil;
}

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
        
        [self.conversation deleteMessageWithId:model.message.messageId error:nil];
        [self.messsagesSource removeObject:model.message];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        if ([self.dataArray count] == 0) {
            self.messageTimeIntervalTag = -1;
        }
    }
    
    self.menuIndexPath = nil;
}

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    //用户可以根据自己的用户体系，根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    
    NSString * nickname =  [model nickname];
    NSString *imgStr = @"";
    
    
    if ([nickname isEqualToString:self.otherHuanXinId]) {
        
        imgStr = self.otherHeadImg;
        model.nickname = self.otherName;//用户昵称
    }else {
        imgStr = self.myHeadImg;
        model.nickname = self.myName;//用户昵称
    }
    
    model.nickname = @"";
    model.avatarImage = [UIImage imageNamed:@"369"];//默认头像
    if ([nickname isEqualToString:self.otherHuanXinId]) {

        model.avatarURLPath = [QQYYURLDefineTool getImgURLWithStr:_otherHeadImg];//头像
    }else {
        model.avatarURLPath =  [QQYYURLDefineTool getImgURLWithStr: _myHeadImg];//头像
    }

    if ([model text]) {
        self.lastText = [model text];
    }
    if ([model address]) {
        self.lastText = @"位置";
    }
 
    if ([model mediaDuration] != 0) {
        self.lastText = @"语音";
    }
    if ([model imageSize].width != 0 ) {
        self.lastText = @"图片";
    }

    return model;
}


@end
