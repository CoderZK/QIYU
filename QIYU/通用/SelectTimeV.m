//
//  SelectTimeV.m
//  动画
//
//  Created by kunzhang on 17/10/19.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import "SelectTimeV.h"

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define aspectRatio(x) x
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define blackFontColor [UIColor grayColor]
#define regularFontWithSize(x) [UIFont systemFontOfSize:x]
#define naviBarColor [UIColor blueColor]

@interface SelectTimeV ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSInteger yearIndex;
    
    NSInteger monthIndex;
    
    NSInteger dayIndex;
    
    NSInteger hourIndex;
    
    NSInteger minIndex;
    
    UIView *topV;
}
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *yearArray;

@property (nonatomic, strong) NSMutableArray *monthArray;

@property (nonatomic, strong) NSMutableArray *dayArray;



@end


@implementation SelectTimeV

- (NSMutableArray *)yearArray {
    
    if (_yearArray == nil) {
        
        _yearArray = [NSMutableArray array];

        for (int year = 1949; year < 2050; year++) {
            
            NSString *str = [NSString stringWithFormat:@"%d年", year];
            
            [_yearArray addObject:str];
        }

    }
    
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    
    if (_monthArray == nil) {
        
        _monthArray = [NSMutableArray array];
        
        for (int month = 1; month <= 12; month++) {
            
            NSString *str = [NSString stringWithFormat:@"%02d月", month];
            
            [_monthArray addObject:str];
        }
    }
    
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    
    if (_dayArray == nil) {
        
        _dayArray = [NSMutableArray array];
        
        for (int day = 1; day <= 31; day++) {
            
            NSString *str = [NSString stringWithFormat:@"%02d日", day];
            
            [_dayArray addObject:str];
        }
    }
    
    return _dayArray;
}


- (instancetype)init
{
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    if (self) {
        
        hourIndex = minIndex = 0;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.frame;
        [self addSubview:button];
        
        [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
        
        topV = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, aspectRatio(40))];
        topV.backgroundColor = RGBACOLOR(242, 242, 242, 1.0);
        [self addSubview:topV];
        
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
        
        UILabel * label =[[UILabel alloc] initWithFrame: CGRectMake(100, 0, screenWidth - 200 , 40)];
        label.font = regularFontWithSize(15);
        label.textColor = RGBACOLOR(30, 30, 30, 1);
        label.text = @"选择日期";
        label.textAlignment = 1;
        [topV addSubview:label];
        
        
        
        [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.tag = 100;
        [yesBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        yesBtn.tag = 101;

        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topV.frame), screenWidth, aspectRatio(207))];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
        unsigned unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        // 获取不同时间字段的信息
        NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
        
        yearIndex = [self.yearArray indexOfObject:[NSString stringWithFormat:@"%ld年", comp.year]];
        monthIndex = [self.monthArray indexOfObject:[NSString stringWithFormat:@"%02ld月", comp.month]];
        dayIndex = [self.dayArray indexOfObject:[NSString stringWithFormat:@"%02ld日", comp.day]];
        
        [_pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [_pickerView selectRow:monthIndex inComponent:1 animated:YES];
        [_pickerView selectRow:dayIndex inComponent:2 animated:YES];
        
        [self pickerView:_pickerView didSelectRow:yearIndex inComponent:0];
        [self pickerView:_pickerView didSelectRow:monthIndex inComponent:1];
        [self pickerView:_pickerView didSelectRow:dayIndex inComponent:2];
        
        if (self.isBaoHanHHmm) {
            [_pickerView selectRow:yearIndex inComponent:3 animated:YES];
            [_pickerView selectRow:monthIndex inComponent:4 animated:YES];
            [self pickerView:_pickerView didSelectRow:hourIndex inComponent:3];
            [self pickerView:_pickerView didSelectRow:minIndex inComponent:4];
        }
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[_pickerView viewForRow:yearIndex forComponent:0];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
            label = (UILabel *)[_pickerView viewForRow:monthIndex forComponent:1];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
            label = (UILabel *)[_pickerView viewForRow:dayIndex forComponent:2];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
            if (self.isBaoHanHHmm) {
                label = (UILabel *)[_pickerView viewForRow:hourIndex forComponent:3];
                label.textColor = RGBACOLOR(30, 30, 30, 1.0);
                label.font = regularFontWithSize(16);
                
                label = (UILabel *)[_pickerView viewForRow:minIndex forComponent:4];
                label.textColor = RGBACOLOR(30, 30, 30, 1.0);
                label.font = regularFontWithSize(16);
            }

            
        });
        
        [UIView animateWithDuration:0.25 animations:^{
            
            topV.frame = CGRectMake(0, screenHeight - aspectRatio(247), screenWidth, aspectRatio(40));
            _pickerView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), screenWidth, aspectRatio(207));
        }];
        
    }
    return self;
}


- (void)cancel:(UIButton *)button {
    
     if (button.tag == 101){
         NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",((UILabel *)[_pickerView viewForRow:yearIndex forComponent:0]).text, ((UILabel *)[_pickerView viewForRow:monthIndex forComponent:1]).text, ((UILabel *)[_pickerView viewForRow:dayIndex forComponent:2]).text];
         
         
         timeStr = [timeStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
         
         timeStr = [timeStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
         
         timeStr = [timeStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
         
         
         //此处是根据FM 的需求添加的
         NSDate * nowDate = [NSDate date];
         NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyy-MM-dd";
         NSDate * dateTwo = [formatter dateFromString:timeStr];
         NSComparisonResult result = [dateTwo compare:nowDate];
         
         if (self.isCanSelectOld) {
             if (result==NSOrderedDescending || result==NSOrderedSame) {
                 //选中的比当前日期大
                 [SVProgressHUD showErrorWithStatus:@"请选择日期今天及之前的日期"];
                 return;
             }else {
                
             }
         }else {
             
             if (result==NSOrderedDescending) {
                 //选中的比当前日期大
             }else {
                 [SVProgressHUD showErrorWithStatus:@"请选择日期大于今天的日期"];
                 return;
             }
         }
         if (_isBaoHanHHmm) {
             
             timeStr = [timeStr stringByAppendingString: [NSString stringWithFormat:@" %02ld:%02ld",hourIndex,minIndex]];
             
         }
     
         
         
        [self remove];
        if (_block) {

            _block(timeStr);
            
        }
       
     }else {
          [self remove];
     }
}


#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.isBaoHanHHmm) {
        return 5;
    }
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
        
    }else if(component == 1) {
        
        return self.monthArray.count;
        
    }else if(component == 2){
        
        switch (monthIndex + 1) {
                
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: return 31;
                
            case 4:
            case 6:
            case 9:
            case 11: return 30;
                
            default: return 28;
        }
    }else if (component == 3) {
        
        return 24;
        
    }else {
        
        return 60;
        
    }
}


- (void)remove {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        topV.frame = CGRectMake(0, screenHeight, screenWidth, aspectRatio(40));
        _pickerView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), screenWidth, aspectRatio(207));
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}
#pragma mark -UIPickerView的代理

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        yearIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
        });
        
    }else if (component == 1) {
        
        monthIndex = row;
        
        [pickerView reloadComponent:2];
        
        
        if (monthIndex + 1 == 4 || monthIndex + 1 == 6 || monthIndex + 1 == 9 || monthIndex + 1 == 11) {
            
            if (dayIndex + 1 == 31) {
                
                dayIndex--;
            }
        }else if (monthIndex + 1 == 2) {
            
            if (dayIndex + 1 > 28) {
                dayIndex = 27;
            }
        }
        [pickerView selectRow:dayIndex inComponent:2 animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
            label = (UILabel *)[pickerView viewForRow:dayIndex forComponent:2];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
        });
    }else if (component == 2)  {
        
        dayIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
        });
    }else if (component == 3) {
        
        hourIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
        });
        
    }else {
        
        minIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = RGBACOLOR(30, 30, 30, 1.0);
            label.font = regularFontWithSize(16);
            
        });
        
    }
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
    if (component == 0) {
        
        genderLabel.text = self.yearArray[row];
        
    }else if (component == 1) {
        
        genderLabel.text = self.monthArray[row];
        
    }else if (component == 2){
        
        genderLabel.text = self.dayArray[row];
    }else {
        genderLabel.text =  [NSString stringWithFormat:@"%02ld",row];
    }
    
    return genderLabel;
}
@end
