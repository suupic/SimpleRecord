//
// Created by skywalker on 13-5-11.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "SimpleRecordEnumConstants.h"
#import "SimpleRecordColumn.h"
#import "SimpleRecordRelation.h"
#import "SimpleRecordTable.h"
#import "SimpleRecordIndex.h"

static NSString *dbpath;

@interface SimpleRecord : NSObject

@property (nonatomic, strong) FMDatabase *db;

+ (void) use:(NSString *)dbFilePath;                //使用数据文件
- (BOOL) establishConnection;                       //建立连接

+ (SimpleRecord *)shared;                           //共享对象

@end