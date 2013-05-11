//
// Created by skywalker on 13-5-11.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface AR : NSObject

@property (nonatomic, strong) FMDatabase *db;
- (BOOL *) connectTo:(NSString *)dbpath;

+ (AR *)shared;

@end