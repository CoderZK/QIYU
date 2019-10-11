//
//  AAAAFMDBSignle.h
//  QIYU
//
//  Created by zk on 2019/10/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>

@interface AAAAFMDBSignle : NSObject
+(AAAAFMDBSignle *)shareFMDB;
- (FMDatabase *)fd;
@end
