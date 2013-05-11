//
// Created by skywalker on 13-5-11.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <objc/runtime.h>
#import "ARModel.h"
#import "FMDatabaseAdditions.h"

FMDatabase *db;

@implementation ARModel

@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        db = [AR shared].db;
    }
    return self;
}

//    - (BOOL) save {
//
//        FMDatabase *db = [FMDatabase databaseWithPath:@"/tmp/tmp.db"];
//        [db open];
//        db.logsErrors = YES;
//        [db executeUpdate:@"CREATE TABLE FMSBOOK ( \
//     uid INTEGER PRIMARY KEY AUTOINCREMENT, \
//     name VARCHAR(512) NOT NULL DEFAULT '', \
//     authorId INTEGER DEFAULT 0 \
//	 )"];
//
//        id inspectedClass = self;
//
//        NSString *className = [NSString stringWithFormat:@"%s", class_getName([inspectedClass class])];
//        NSLog(@"class name: %s", class_getName([inspectedClass class]));
//        unsigned int outCount, i;
//        objc_property_t *properties = class_copyPropertyList([inspectedClass class], &outCount);
//        NSString *columnNames = @"";
//        NSString *values = @"";
//
//        for (i = 0; i < outCount; i++) {
//            objc_property_t property = properties[i];
//            NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
//            fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
//            NSString *columnName = @"";
//            NSString *value = @"";
//
//            if (i == 0) {
//                columnName = [NSString stringWithFormat:@"%s", property_getName(property)];
//            } else {
//                columnName = [NSString stringWithFormat:@", %s", property_getName(property)];
//            }
//            if ([propertyName isEqualToString:@"uid"]) {
//                value = @"NULL";
//            } else {
//                NSLog(@"perform %@", propertyName);
//                SEL sel = sel_registerName([propertyName UTF8String]);
//                value = [NSString stringWithFormat:@", '%@'", [[self performSelector:sel] description]];
//            }
//
//            columnNames = [columnNames stringByAppendingString:columnName] ;
//            if (value) {
//                values = [values stringByAppendingString:value];
//            } else {
//                values = [values stringByAppendingString:Nil];
//            }
//        }
//
//        NSString *query = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES(%@);",
//                                                     className,
//                                                     columnNames,
//                                                     values
//        ];
//        NSLog(@"%@", query);
//        [db beginTransaction];
////    id result =  objc_msgSend(db, sel_getUid("executeUpdate:"), query, self.name, self.authorId);
////    id result =  objc_msgSend(db, sel_getUid("executeUpdate:"), @"INSERT INTO FMSBook(uid, name, authorId) VALUES(NULL,?,?)", self.name, self.authorId);
////    id result = objc_msgSend(db, sel_getUid("executeQuery:"), @"SELECT 1 FROM FMSBOOK");
//        BOOL *result = [db executeUpdate:query];
////    NSLog(@"result: %@", [result description]);
//
////    BOOL *result = [db executeUpdate:@"INSERT INTO book(book_id, name, description, date_created, date_updated, begin_date, end_date, total_income, total_expenditure, total_balance, currency_type, background_img, current, status) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", book.name, book.description, dateCreated, dateUpdated, beginDate, endDate, book.totalIncome, book.totalExpenditure, book.totalBalance, book.currencyType, book.backgroundImg, book.current, book.status];
//        if (result) {
//            [db commit];
//            NSLog(@"commit 1");
//        } else {
//            [db rollback];
//        }
//
//        FMResultSet *s = [db executeQuery:@"SELECT * FROM FMSBooK;", className];
//        if ([s next]) {
//            int totalCount = [s intForColumnIndex:0];
//            NSLog(@"name: %s", [s stringForColumn:@"NAME"]);
////        NSLog(@"count: %d", totalCount);
//        }
//
//        return YES;
//    }
+ (BOOL)createTable {
    if([self isTableExist]){
       NSLog(@"Table %@ exist.", [self tableName]);
       return YES;
    }else{
        [db executeUpdate:@"CREATE TABLE FMSBOOK ( \
     uid INTEGER PRIMARY KEY AUTOINCREMENT, \
     name VARCHAR(512) NOT NULL DEFAULT '', \
     authorId INTEGER DEFAULT 0 \
	 )"];
        return NO;
    }
}

+ (BOOL)isTableExist {
    NSString *tableName = [self tableName];

    FMResultSet *rs = [db executeQuery:@"select [sql] from sqlite_master where [type] = 'table' and lower(name) = ?", tableName];

    //if at least one next exists, table exists
    BOOL returnBool = [rs next];

    //close and free object
    [rs close];

    return returnBool;
}

+ (BOOL)dropTable {
    NSString *queryString = [NSString stringWithFormat:@"DROP TABLE %@;", [self.class tableName]];
    NSLog(queryString);

    [db closeOpenResultSets];

    if([db executeUpdate:queryString]){
        NSLog(@"Drop table success.");
    }
    else{
        NSLog(@"Drop table failed: %@, %@", [db lastError], [db lastErrorCode]);
    }
    return NO;
}


- (BOOL) save {
    NSString *tableName = [self.class tableName];
    NSMutableDictionary *properties = self.ar_attributes;
    __block NSString *columnNames = @"";
    __block NSString *values = @"";

    [properties enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        NSString *propertyName = [NSString stringWithFormat:@"%@", key];
        NSString *propertyType = [NSString stringWithFormat:@"%@", obj];

        NSString *columnName = @"";
        NSString *value = @"";

        if ([propertyName isEqualToString:@"uid"]) {
            columnName = [NSString stringWithFormat:@"'%@'", propertyName];
            value = @"NULL";
        } else {
            columnName = [NSString stringWithFormat:@", '%@'", propertyName];
            SEL sel = sel_registerName([propertyName UTF8String]);
            value = [NSString stringWithFormat:@", '%@'", [[self performSelector:sel] description]];
        }

        columnNames = [columnNames stringByAppendingString:columnName] ;
        if (value) {
            values = [values stringByAppendingString:value];
        } else {
            values = [values stringByAppendingString:Nil];
        }
    }];

    NSString *query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(%@) VALUES(%@);",
                                                 tableName,
                                                 columnNames,
                                                 values];
    NSLog(@"QUERY: %@", query);
    [db beginTransaction];
    BOOL *result = [db executeUpdate:query];

    if (result) {
        db.commit;
        NSLog(@"commit success");
    } else {
        db.rollback;
    }

//    FMResultSet *s = [self.class findOne];
    FMResultSet *s = [self.class findByUID:69];
    while ([s next]) {
        NSLog(@"uid: %@", [s stringForColumn:@"uid"]);
        NSLog(@"name: %@", [s stringForColumn:@"NAME"]);
    }
    return result;
}

- (BOOL)updateAttributes:(NSDictionary *)attributes {
    return NO;
}

- (BOOL)delete {
    return NO;
}
- (NSMutableDictionary *)attr_accessor:(NSDictionary *)attributes {
    self.ar_attributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:
            @"NSInteger" , @"uid", nil];
    [self.ar_attributes addEntriesFromDictionary:attributes];
    return self.ar_attributes;
}

+ (NSString *)tableName {
    NSString *className = [[NSString stringWithFormat:@"%s", class_getName([self class])] lowercaseString];
    return className;
}

+ (FMResultSet *)findAll {
    FMResultSet *s = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@;", [self tableName]]];
    return s;
}

+ (FMResultSet *)findOne {
    FMResultSet *s = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ limit 1;", [self tableName]]];
    return s;
}

+ (id)findByUID:(NSInteger *)uid {
    FMResultSet *s = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE uid=%d;", [self tableName], uid]];
    return s;
}

+ (FMResultSet *)deleteByUID:(NSInteger *)uid {
    return nil;
}

//- (id)parsedObject:(FMResultSet *)fmResultSet {
//    id obj = [[[self class] alloc]init];
//    return obj;
//}

@end