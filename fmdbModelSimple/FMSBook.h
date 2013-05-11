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

@property (nonatomic)NSInteger *uid;
@property (nonatomic)NSString *name;
@property (nonatomic)NSNumber *authorId;

- (NSString *)description;

@end
