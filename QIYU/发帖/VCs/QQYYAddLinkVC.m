//
//  QQYYAddLinkVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYAddLinkVC.h"

@interface QQYYAddLinkVC ()
@property (weak, nonatomic) IBOutlet UIView *linkV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UIButton *BT;

@end

@implementation QQYYAddLinkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加链接";
    self.BT.clipsToBounds = YES;
    self.BT.layer.cornerRadius = 3;
    self.linkV.hidden = YES;
    UIButton * clickBt=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    [clickBt setTitle:@"完成" forState:UIControlStateNormal];
    clickBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    clickBt.titleLabel.font = kFont(14);
    [clickBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clickBt addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    clickBt.tag = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clickBt];
}

- (void)leftOrRightClickAction:(UIButton *)button {
    if (self.linkBlock != nil) {
        self.linkBlock(self.TF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)action:(id)sender {
    
    self.linkV.hidden = NO;
    self.titleLB.text = self.TF.text;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
