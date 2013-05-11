//
// Created by skywalker on 13-5-11.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SimpleRecord.h"

// declare our class
@class SimpleRecordModel;
FMDatabase *db;

// define the protocol for the delegate
@protocol SimpleRecordModelDelegate

// define protocol functions that can be used in any class using this delegate
//+ (NSDictionary *)attr_accessor:(NSDictionary *)attributes;

@end

@interface SimpleRecordModel : NSObject

// define delegate property
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) NSMutableDictionary *ar_attributes;

- (BOOL) save;
- (BOOL) updateAttributes:(NSDictionary *)attributes;
- (BOOL) delete;
+ (BOOL) createTable;
+ (BOOL) dropTable;
+ (BOOL) isTableExist;
+ (FMResultSet *) findAll;
+ (FMResultSet *) findOne;
+ (id) findByUID:(NSInteger)uid;
+ (BOOL) deleteByUID:(NSInteger)uid;
+ (NSString *) tableName;

- (NSMutableDictionary *)attr_accessor:(NSDictionary *)attributes;
@end