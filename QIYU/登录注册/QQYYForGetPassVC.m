//
//  QQYYForGetPassVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYForGetPassVC.h"

@interface QQYYForGetPassVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *confrimBt;
@property (weak, nonatomic) IBOutlet UIButton *gouBt;

@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;

@end

@implementation QQYYForGetPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    self.view1.layer.cornerRadius = self.view2.layer.cornerRadius = self.view3.layer.cornerRadius = 25;
    self.confrimBt.layer.cornerRadius= 22.5;
    self.view3.clipsToBounds =self.view2.clipsToBounds = self.view1.clipsToBounds = self.confrimBt.clipsToBounds = YES;
    self.view3.layer.borderWidth = self.view1.layer.borderWidth =  self.view2.layer.borderWidth = 0.5;
    self.view3.layer.borderColor = self.view1.layer.borderColor = self.view2.layer.borderColor = CharacterBlack40.CGColor;
}

- (IBAction)confirmAction:(id)sender {
   
    
    
}

- (IBAction)sendCode:(id)sender {
   
    
}


- (void)timeAction {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
    self.codeBt.userInteractionEnabled = NO;
    self.number = 60;
    
    
}

- (void)timerStar {
    _number = _number -1;
    if (self.number > 0) {
        [self.codeBt setTitle:[NSString stringWithFormat:@"%lds后重发",_number] forState:UIControlStateNormal];
    }else {
        [self.codeBt setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.codeBt.userInteractionEnabled = YES;
    }
    
    
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
