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


- (IBAction)action:(id)sender {
    self.linkV.hidden = NO;
    self.titleLB.text = self.TF.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加链接";
    self.BT.clipsToBounds = YES;
    self.BT.layer.cornerRadius = 3;
    self.linkV.hidden = YES;
    UIButton * newClickUpAndInsideBT=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    [newClickUpAndInsideBT setTitle:@"完成" forState:UIControlStateNormal];
    newClickUpAndInsideBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    newClickUpAndInsideBT.titleLabel.font = kFont(14);
    [newClickUpAndInsideBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newClickUpAndInsideBT addTarget:self action:@selector(leftOrRightClickAction:) forControlEvents:UIControlEventTouchUpInside];
    newClickUpAndInsideBT.tag = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:newClickUpAndInsideBT];
}



- (void)leftOrRightClickAction:(UIButton *)button {
    if (self.linkBlock != nil) {
        self.linkBlock(self.TF.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)LJ {
    int ff = 0;
    for (int i = 0 ; i < 20; i++) {
        ff = arc4random() % 21;
        if (ff / 2 == 0) {
            ff = ff * 3;
            NSLog(@"%d",ff);
        }
    }
    
    [self LJwithInt:ff];
    
}

- (int)LJwithInt:(int )a{
    
    for (int dd = 0 ; dd < a; dd++) {
        if (dd* a % 2 == 0) {
            return dd + 2;
            
        }else {
            return dd+1;
        }
    }
    return 1;
}


@end
