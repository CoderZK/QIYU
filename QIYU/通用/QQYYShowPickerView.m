//
//  QQYYShowPickerView.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYShowPickerView.h"

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define aspectRatio(x) x
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define blackFontColor [UIColor grayColor]
#define regularFontWithSize(x) [UIFont systemFontOfSize:x]
#define naviBarColor [UIColor blueColor]

@interface QQYYShowPickerView()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *topV;
    NSInteger selectIndex;
    NSInteger selectCityIndex;
    BOOL _isCity;
    NSString * proviceID;
}
@property (nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray<QQYYTongYongModel *> *cityArr;


@end

@implementation QQYYShowPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        selectIndex = 0;
        selectCityIndex = 0;
        self.cityArr = @[].mutableCopy;
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.frame;
        [self addSubview:button];
        
        [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        
        topV = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, aspectRatio(40))];
        topV.backgroundColor = RGBACOLOR(242, 242, 242, 1.0);
        [self addSubview:topV];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topV.frame), screenWidth, aspectRatio(207))];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
         [self pickerView:_pickerView didSelectRow:selectIndex inComponent:0];
        
        UILabel *label1 = (UILabel *)[_pickerView viewForRow:selectIndex forComponent:0];
        label1.textColor = RGBACOLOR(30, 30, 30, 1.0);
        label1.font = regularFontWithSize(16);
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];

        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, aspectRatio(100), aspectRatio(40));
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:regularFontWithSize(16)];
        [topV addSubview:cancelBtn];
        
        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake(screenWidth - aspectRatio(100), 0, aspectRatio(100), aspectRatio(40));
        [yesBtn setTitle:@"确定" forState:UIControlStateNormal];
        [yesBtn setTitleColor:BlueColor forState:UIControlStateNormal];
        [yesBtn.titleLabel setFont:regularFontWithSize(16)];
        [topV addSubview:yesBtn];
        
        
        [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.tag = 100;
        [yesBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        yesBtn.tag = 101;
        
        UILabel * label =[[UILabel alloc] initWithFrame: CGRectMake(100, 0, screenWidth - 200 , 40)];
        label.font = regularFontWithSize(15);
        label.textColor = RGBACOLOR(30, 30, 30, 1);
        label.text = @"请选择";
        label.textAlignment = 1;
        [topV addSubview:label];
        
        
        
    }
    return self;
}



- (void)setProvityArr:(NSMutableArray<QQYYTongYongModel *> *)provityArr {
    _provityArr = provityArr;
}

- (void)showWithDataArr:(NSArray *)arr {
    self.dataArray = arr;
    [self.pickerView reloadComponent:0];

   
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        topV.frame = CGRectMake(0, screenHeight - aspectRatio(247), screenWidth, aspectRatio(40));
        _pickerView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), screenWidth, aspectRatio(207));
    }];
    
}

- (void)setIsAddress:(BOOL)isAddress {
    _isAddress = isAddress;
}

- (void)cancel:(UIButton *)button {
    
    if (button.tag == 101){
       
        if (self.isAddress) {
          
            if (_isCity) {
                [self remove];
                if (self.didSelectCityBlock != nil) {
                    self.didSelectCityBlock(self.cityArr[selectCityIndex].name, self.cityArr[selectCityIndex].ID,self.provityArr[selectIndex].name,proviceID);
                }
                
            }else {
                
                _isCity = YES;
                proviceID = self.provityArr[selectIndex].ID;
                [self getCityArr];
            }
        }else {
            [self remove];
            if (self.didSelectIndexBlock != nil) {
                self.didSelectIndexBlock(selectIndex);
            }
        }
        
       
    }else if (button.tag == 100 ){
        if (self.isAddress) {
            if (_isCity) {
                _isCity = NO;
                selectCityIndex = 0;
                [self.pickerView reloadAllComponents];
                [self.pickerView selectRow:0 inComponent:0 animated:YES];
                [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
            }else {
               [self remove];
            }
        }else {
          [self remove];
        }
    }else {
        [self remove];
    }
}




#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.isAddress && _isCity) {
        return self.cityArr.count;
    }
    return self.dataArray.count;
}


- (void)remove {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        topV.frame = CGRectMake(0, screenHeight, screenWidth, aspectRatio(40));
        _pickerView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), screenWidth, aspectRatio(207));
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

- (void)getCityArr {

    [QQYYRequestTool networkingPOST:[QQYYURLDefineTool cityListURL] parameters:self.provityArr[selectIndex].ID success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 0) {
            
            self.cityArr = [QQYYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
            [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
            
        }else {
     
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
        
    }];
    
    
    
}

#pragma mark -UIPickerView的代理

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.isAddress) {
        if (_isCity) {
            selectCityIndex = row;
        }else {
          selectIndex = row;
        }
    }else {
       selectIndex = row;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
        label.textColor = RGBACOLOR(30, 30, 30, 1.0);
        label.font = regularFontWithSize(16);
        
    });
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //    //设置分割线的颜色
    //    for(UIView *singleLine in pickerView.subviews)
    //    {
    //        if (singleLine.frame.size.height < 1)
    //        {
    //            singleLine.backgroundColor = kSingleLineColor;
    //        }
    //    }
    
    //设置文字的属性
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.textColor = RGBACOLOR(153, 153, 153, 1.0);
    genderLabel.font = regularFontWithSize(14);
    if (self.isAddress && _isCity) {
         genderLabel.text = self.cityArr[row].name;
    }else {
       genderLabel.text = self.dataArray[row];
    }
    return genderLabel;
}

@end
