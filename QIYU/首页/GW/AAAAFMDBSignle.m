//
//  AAAAFMDBSignle.m
//  QIYU
//
//  Created by zk on 2019/10/10.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "AAAAFMDBSignle.h"

@interface AAAAFMDBSignle()
@end
@implementation AAAAFMDBSignle
+ (AAAAFMDBSignle *)shareFMDB {
    static AAAAFMDBSignle * single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[AAAAFMDBSignle alloc] init];
    });
    return single;
}
- (FMDatabase *)fd {
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"AAAA.db"];
    NSString *filePathTwo = [[NSBundle mainBundle] pathForResource:@"AAAA" ofType:@"db"];
    NSFileManager * fileManger = [NSFileManager defaultManager];
    NSError * error;
    
    if ([fileManger fileExistsAtPath:filePath] == NO) {
        BOOL isOK = [fileManger copyItemAtPath:filePathTwo toPath:filePath error:&error];
        if (isOK) {
            NSLog(@"%@",@"复制成功\n\n\n");
        }else {
            NSLog(@"%@",@"复制失败\n\n\n");
        }
    }else {
//        if ([fileManger fileExistsAtPath:filePathTwo] == NO) {
//            BOOL isOK = [fileManger copyItemAtPath:filePath toPath:res error:&error];
//            if (isOK) {
//                NSLog(@"%@",@"复制成功\n\n\n");
//            }else {
//                NSLog(@"%@",@"复制失败\n\n\n");
//            }
//        }
//        BOOL isDeleate = [fileManger removeItemAtPath:filePath error:&error];
//        if (isDeleate) {
//            BOOL isOK = [fileManger copyItemAtPath:filePath toPath:filePathTwo error:&error];
//            if (isOK) {
//                NSLog(@"%@",@"复制成功\n\n\n");
//            }else {
//                NSLog(@"%@",@"复制失败\n\n\n");
//            }
//        }else {
//            NSLog(@"%@",@"删除成功");
//
//        }
    }
    //实例化FMDataBase对象
    NSLog(@"---path111:%@",filePath);
    NSLog(@"---path222:%@",filePathTwo);
//    NSLog(@"---path:%@",filePathThree);
    FMDatabase *  fmdb = [FMDatabase databaseWithPath:filePath];
    return fmdb;
}

-(void)initDataBase{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"student.db"];
    NSLog(@"---path:%@",filePath);
    FMDatabase *  fmdb = [FMDatabase databaseWithPath:filePath];
    if([fmdb open]) {
        //初始化数据表
        [fmdb close];
    }else{
        NSLog(@"数据库打开失败---%@", fmdb.lastErrorMessage);
    }
}
@end

