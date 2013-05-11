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

+ (SimpleRecordColumn *)init:(NSString *)name type:(enum_DataType)type isNull:(BOOL)isNull isPK:(BOOL)isPK default:(id)defaultValue {
    SimpleRecordColumn *column = [[self alloc] init];
    if(!name || !type) {
        return nil;
    }else {
        column.name = name;
        column.type = type;
        column.isNull = isNull ? isNull : NO;
        column.isPK = isPK ? isPK : NO;
        column.defaultValue = defaultValue ? defaultValue : Nil;
        return column;
    }
}

@end