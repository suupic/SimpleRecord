//
//  FMSBook.h
//  fmdbModelSimple
//
//  Created by skywalker on 13-5-4.
//  Copyright (c) 2013年 skywalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleRecordModel.h"

@interface FMSBook : SimpleRecordModel <SimpleRecordModelDelegate, NSCoding>

@property (nonatomic)NSInteger id;
@property (assign, nonatomic) NSString *name;                 //头像
@property (assign, nonatomic) NSString *avatar;                 //头像
@property (assign, nonatomic) NSNumber *type;                   //类型
@property (assign, nonatomic) NSNumber *source;                 //来源, enum:userSource
@property (assign, nonatomic) NSString *sourceNickname;         //来源中的昵称
@property (assign, nonatomic) NSString *sourceAccount;          //来源账号

- (NSString *)description;

@end
