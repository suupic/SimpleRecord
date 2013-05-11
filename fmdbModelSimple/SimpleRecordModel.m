//
// Created by skywalker on 13-5-11.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <objc/runtime.h>
#import "SimpleRecordModel.h"
#import "FMDatabaseAdditions.h"

FMDatabase *db;

@implementation SimpleRecordModel

@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        db = [SimpleRecord shared].db;
    }
    return self;
}

+ (BOOL)createTable {
    if([self isTableExist]){
       NSLog(@"Table %@ exist.", [self tableName]);
       return YES;
    }else{
       BOOL result = [db executeUpdate:@"CREATE TABLE FMSBOOK ( \
     uid INTEGER PRIMARY KEY AUTOINCREMENT, \
     name VARCHAR(512) NOT NULL DEFAULT '', \
     authorId INTEGER DEFAULT 0 \
	 )"];
       return result;
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
    NSLog(@"%@",queryString);

    [db closeOpenResultSets];

    if([db executeUpdate:queryString]){
        NSLog(@"Drop table success.");
    }
    else{
        NSLog(@"Drop table failed: %@, %d", [db lastError], [db lastErrorCode]);
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
//        NSString *propertyType = [NSString stringWithFormat:@"%@", obj];

        NSString *columnName = @"";
        NSString *value = @"";

        if ([propertyName isEqualToString:@"uid"]) {
            columnName = [NSString stringWithFormat:@"'%@'", propertyName];
            value = @"NULL";
        } else {
            columnName = [NSString stringWithFormat:@", '%@'", propertyName];
            SEL sel = sel_registerName([propertyName UTF8String]);
            #pragma clang diagnostic push  //用于忽略performSelector的“performselector may cause a leak because its selector is unknow”警告
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            value = [NSString stringWithFormat:@", '%@'", [[self performSelector:sel] description]];
            #pragma clang diagnostic pop
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
    BOOL boolresult = [db executeUpdate:query];

    if (boolresult) {
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
    return boolresult;
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

+ (id)findByUID:(NSInteger)uid {
    FMResultSet *s = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE uid=%d;", [self tableName], uid]];
    return s;
}

+ (BOOL)deleteByUID:(NSInteger)uid {
    return NO;
}

//- (id)parsedObject:(FMResultSet *)fmResultSet {
//    [fmResultSet
//    id obj = [[[self class] alloc]init];
//    return obj;
//}

@end