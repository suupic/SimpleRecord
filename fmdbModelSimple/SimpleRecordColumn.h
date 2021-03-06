//
// Created by skywalker on 13-5-12.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SimpleRecordEnumConstants.h"


@interface SimpleRecordColumn : NSObject

@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) ColumnDataType type;
@property (nonatomic, assign) BOOL isNull;
@property (nonatomic, assign) BOOL isPK;
@property (nonatomic, assign) id defaultValue;

- (SimpleRecordColumn *)initWithParamers:(NSString *)name type:(ColumnDataType)type isNull:(BOOL)isNull isPK:(BOOL)isPK default:(id)defaultValue;

- (NSString *)toCreateSQLPart;
- (NSString *)sqlConvertOfName;
- (NSString *)sqlConvertOfType;
- (NSString *)sqlConvertOfIsNull;
- (NSString *)sqlConvertOfIsPK;
- (NSString *)sqlConvertOfDefaultValue;

@end