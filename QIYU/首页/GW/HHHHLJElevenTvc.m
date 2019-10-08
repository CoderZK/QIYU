//
//  HHHHLJElevenTvc.m
//  QIYU
//
//  Created by zk on 2019/10/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHHHLJElevenTvc.h"
#import "HHHHLJElevenCell.h"
@interface HHHHLJElevenTvc ()

@end

@implementation HHHHLJElevenTvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"hjgj";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHHHLJElevenCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHHHLJElevenCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textTF.text = @"textField";
    cell.textV.text = @"textView";
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
