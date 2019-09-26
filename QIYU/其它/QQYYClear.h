//
//  QQYYClear.h
//  QIYU
//
//  Created by zk on 2019/9/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^cleanCacheBlock)();
@interface QQYYClear : NSObject
+(void)cleanCache:(cleanCacheBlock)block;
+(float)folderSizeAtPath;
@end

