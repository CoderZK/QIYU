//
//  QQYYTongXunLuTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYTongXunLuTVC.h"
#import "QQYYMineFriendsCell.h"
#import "QQYYHuaTiTVC.h"
@interface QQYYTongXunLuTVC ()

@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)NSMutableArray *rightDataArr;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;

@end

@implementation QQYYTongXunLuTVC

- (NSMutableDictionary *)dataDict {
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

- (NSMutableArray *)rightDataArr {
    if (_rightDataArr == nil) {
        _rightDataArr = [NSMutableArray array];
    }
    return _rightDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    self.navigationItem.title = @"好友";
    [self.tableView registerClass:[QQYYMineFriendsCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.sectionIndexColor = CharacterBlack40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton * clickBt=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    
    //    [clickBt setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [clickBt setTitle:@"完成" forState:UIControlStateNormal];
    clickBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    clickBt.titleLabel.font = kFont(14);
    [clickBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clickBt addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    clickBt.tag = 11;
    //    [self.view addSubview:clickBt];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clickBt];
    

    [self acquireDataFromServe];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self acquireDataFromServe];
    }];

    
    
}

- (void)leftOrRightClickAction:(UIButton *)button {
    
    NSMutableArray * nameArr = @[].mutableCopy;
    NSMutableArray * idArr = @[].mutableCopy;
    for (int i = 0 ; i < self.rightDataArr.count; i++) {
        
        for (zkHomelModel * model  in self.dataDict[self.rightDataArr[i]]) {
            if (model.isSelect) {
                [nameArr addObject:model.nickName];
                [idArr addObject:model.userId];
            }
        }
        
        
    }
    
    if (self.sendFriendsBlock != nil) {
        self.sendFriendsBlock([nameArr componentsJoinedByString:@","], [idArr componentsJoinedByString:@","]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


//排序
- (void)paiXunAction {
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        
        if (self.dataArray[i]) {
            //将取出的名字转换成字母
            NSMutableString *pinyin = [self.dataArray[i].nickName mutableCopy];
            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
            
            /*多音字处理*/
            NSString * firstStr = [self.dataArray[i].nickName substringToIndex:1];
            if ([firstStr compare:@"长"] == NSOrderedSame)
            {
                if (pinyin.length>=5)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
                }
            }
            else if ([firstStr compare:@"沈"] == NSOrderedSame)
            {
                if (pinyin.length>=4)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
                }
            }
            else if ([firstStr compare:@"厦"] == NSOrderedSame)
            {
                if (pinyin.length>=3)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
                }
            }
            else if ([firstStr compare:@"地"] == NSOrderedSame)
            {
                if (pinyin.length>=3)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
                }
            }
            else if ([firstStr compare:@"重"] == NSOrderedSame)
            {
                if (pinyin.length>=5)
                {
                    [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
                }
            }
            
            //将拼音转换成大写拼音
            NSString * upPinyin = [pinyin uppercaseString];
            //取出第一个首字母当做字典的key
            NSString * firstChar = [upPinyin substringToIndex:1];
            
            NSMutableArray * arr = [self.dataDict objectForKey:firstChar];
            if (!arr)
            {
                arr = [NSMutableArray array];
                [_dataDict setObject:arr forKey:firstChar];
            }
                if ([self.arr containsObject:self.dataArray[i].userId]) {
                    self.dataArray[i].isSelect = YES;
                }
            [arr addObject:self.dataArray[i]];
        }
        else
        {
            NSMutableArray * arr = [self.dataDict objectForKey:@"#"];
            if (!arr)
            {
                arr = [NSMutableArray array];
                [self.dataDict setObject:arr forKey:@"#"];
            }
            if ([self.arr containsObject:self.dataArray[i].userId]) {
                self.dataArray[i].isSelect = YES;
            }
            [arr addObject:self.dataArray[i]];
        }
        
        
        
    }
    
    self.rightDataArr = [self paixuArrWithArr:self.dataDict.allKeys].mutableCopy;
    if (self.rightDataArr.count > 0 && [[self.rightDataArr firstObject] isEqualToString:@"#"]) {
        [self.rightDataArr removeObjectAtIndex:0];
        [self.rightDataArr addObject:@"#"];
    }
    [self.tableView reloadData];
    
}

- (void)acquireDataFromServe {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(1);
    dict[@"pageSize"] = @(10000000);
    NSString * url = [QQYYURLDefineTool getMyFriendUserListURL];
    
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
      
            NSArray * arr = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            self.dataDict = nil;
            [self paiXunAction];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rightDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataDict[self.rightDataArr[section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQYYMineFriendsCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.type = 5;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   zkHomelModel * model = [self.dataDict[self.rightDataArr[indexPath.section]] objectAtIndex:indexPath.row];
    cell.guanZhuBt.userInteractionEnabled = NO;

    cell.model = model;
    return cell;
    
}


/**每一组的标题*/
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.rightDataArr[section];
}

/** 右侧索引列表*/
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    /*
     索引数组中的"内容"，跟分组无关
     索引数组中的下标，对应的是分组的下标
     return @[@"哇哈哈", @"hello", @"哇哈哈", @"hello", @"哇哈哈", @"hello", @"哇哈哈", @"hello"];
     返回self.carGroup中title的数组
     NSMutableArray *arrayM = [NSMutableArray array];
     for (HMCarGroup *group in self.carGroups) {
     [arrayM addObject:group.title];
     }
     return arrayM;
     KVC是cocoa的大招
     用来间接获取或者修改对象属性的方式
     使用KVC在获取数值时，如果指定对象不包含keyPath的"键名"，会自动进入对象的内部查找
     如果取值的对象是一个数组，同样返回一个数组
     */
    /*例如：
     NSArray *array = [self.carGroups valueForKeyPath:@"cars.name"];
     NSLog(@"%@", array);
     */
    return self.rightDataArr;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        view.backgroundColor = RGB(245, 245, 245);
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 50)];
        lb.font = kFont(15);
        [view addSubview:lb];
        lb.tag = 100;
    }
    
    UILabel * lb = (UILabel *)[view viewWithTag:100];
    lb.text = self.rightDataArr[section];
    
    return view;
}
    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    zkHomelModel * model = [self.dataDict[self.rightDataArr[indexPath.section]] objectAtIndex:indexPath.row];
    model.isSelect = !model.isSelect;
    [self.tableView reloadData];
    
    
    
}



//排序
- (NSArray * )paixuArrWithArr:(NSArray *)arr {
    
    if (arr.count == 0) {
        return arr;
    }
    NSArray *resultkArrSort = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];

    
    return resultkArrSort;
}





@end
