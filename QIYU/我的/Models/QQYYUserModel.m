//
//  QQYYUserModel.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QQYYUserModel.h"

@implementation QQYYUserModel

- (void)setPostInfoVoList:(NSArray *)postInfoVoList {
    _postInfoVoList = [zkHomelModel mj_objectArrayWithKeyValuesArray:postInfoVoList];
}

@end
