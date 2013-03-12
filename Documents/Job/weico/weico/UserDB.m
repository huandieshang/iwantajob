//
//  UserDB.m
//  weico
//
//  Created by 高超 on 3/12/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "UserDB.h"
#import <sqlite3.h>

@implementation UserDB
{
    NSString *_path;
    sqlite3 *_sqlite;
    sqlite3_stmt *_stmt;
}
- (id)init
{
    self = [super init];
    if (self) {
        _path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
        _sqlite = nil;
        int successOpenSql = sqlite3_open([_path UTF8String], &_sqlite);
        if (successOpenSql != SQLITE_OK) {
            [self createTable];
        }
    }
    return self;
}

//创建表
- (BOOL)createTable
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS User (username TEXT primary key, password TEXT, email TEXT)";
    char *error;
    
    int successCreateTable = sqlite3_exec(_sqlite, [sql UTF8String], NULL, NULL, &error);
    if (successCreateTable != SQLITE_OK) {
        NSLog(@"数据库创建失败");
        return NO;
    }
    
    NSLog(@"创建成功");
    return YES;
}

//插入数据
- (void)insertTable
{
    _stmt = nil;
    NSString *sql = @"INSERT INTO User(username,password,email) VALUES (?,?,?)";
    //编译sql语句
    sqlite3_prepare_v2(_sqlite, [sql UTF8String], -1, &_stmt, NULL);
    
    NSString *username  = @"samuelmantou";
    NSString *password  = @"666666";
    NSString *email     = @"samuelmantou@qq.com";
    
    sqlite3_bind_text(_stmt, 1, [username UTF8String], -1, NULL);
    sqlite3_bind_text(_stmt, 2, [password UTF8String], -1, NULL);
    sqlite3_bind_text(_stmt, 3, [email UTF8String], -1, NULL);
    
    int result = sqlite3_step(_stmt);
    if (result == SQLITE_ERROR || result == SQLITE_MISUSE) {
        NSLog(@"数据库插入失败");
        NSLog(@"%d", result);
        return;
    }
    sqlite3_finalize(_stmt);
}

//查询数据
- (void)selectTable
{
    NSString *sql = @"SELECT username,password,email FROM User";
    
    sqlite3_prepare_v2(_sqlite, [sql UTF8String], -1, &_stmt, NULL);
    
    //查询数据
    sqlite3_step(_stmt);
}

//关闭表
- (void)closeSql
{
    sqlite3_close(_sqlite);
}

@end
