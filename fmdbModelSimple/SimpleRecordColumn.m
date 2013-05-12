//
// Created by skywalker on 13-5-12.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SimpleRecordColumn.h"


@implementation SimpleRecordColumn {

}

@synthesize name;
@synthesize type;
@synthesize isNull;
@synthesize isPK;
@synthesize defaultValue;

- (SimpleRecordColumn *)initWithParamers:(NSString *)name type:(ColumnDataType)type isNull:(BOOL)isNull isPK:(BOOL)isPK default:(id)defaultValue {
    SimpleRecordColumn *column = self;
//  FIXME: SimpleRecordColumn初始化异常处理
//  FIXME: 参数和实例变量重复
//    if(!name || !type) {
//        return nil;
//    }else {
        column.name = name;
        column.type = type;
        column.isNull = isNull ? isNull : NO;
        column.isPK = isPK ? isPK : NO;
        column.defaultValue = defaultValue ? defaultValue : Nil;
        return column;
//    }
}

- (NSString *)toCreateSQLPart {
    NSString *columnName = self.name.lowercaseString;
    enum ColumnDataType *columnType = self.type;
    NSString *columnString;

    columnString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                    self.sqlConvertOfName,
                    self.sqlConvertOfType,
                    self.sqlConvertOfIsNull,
                    self.sqlConvertOfIsPK,
                    self.sqlConvertOfDefaultValue];
    return columnString;
}

- (NSString *)sqlConvertOfName {
    return self.name.lowercaseString;
}

- (NSString *)sqlConvertOfType {
    NSString *typeString;
    if(self.type == ColumnDataTypeInteger){
        typeString = @"INTEGER";
    } else if(self.type == ColumnDataTypeString){
        typeString = @"VARCHAR(512)";
    } else if(self.type == ColumnDataTypeDOUBLE){
        typeString = @"DOUBLE";
    } else if(self.type == ColumnDataTypeDate){
        typeString = @"TIMESTAMP";
    }
    return typeString;
}

- (NSString *)sqlConvertOfIsNull {
    NSString *isNullString = self.isNull ? @"" : @"NOT NULL";
    return isNullString;
}

- (NSString *)sqlConvertOfIsPK {
    NSString *isPKString = self.isPK ? @"PRIMARY KEY AUTOINCREMENT" : @"";
    return isPKString;
}

- (NSString *)sqlConvertOfDefaultValue {
    NSString *defaultString;
    if(self.defaultValue){
        defaultString = [NSString stringWithFormat:@"DEFAULT %@", self.defaultValue];
    } else {
        defaultString = @"";
    }
    return defaultString;
}

@end