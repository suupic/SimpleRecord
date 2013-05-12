//
// Created by skywalker on 13-5-12.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SimpleRecord.h"


@interface SimpleRecordTable : NSObject

@property (nonatomic, assign) NSMutableArray *relations;
@property (nonatomic, assign) NSMutableArray *columns;
@property (nonatomic, assign) NSMutableArray *indexes;
@end