//
//  FMSBook.m
//  fmdbModelSimple
//
//  Created by skywalker on 13-5-4.
//  Copyright (c) 2013年 skywalker. All rights reserved.
//

#import "FMSBook.h"

@implementation FMSBook

@synthesize id;
@synthesize name;
@synthesize avatar;
@synthesize type;
@synthesize source;
@synthesize sourceAccount;
@synthesize sourceNickname;

- (id)init {
    if (self = [super init]) {
//        [self attr_accessor:[NSDictionary dictionaryWithObjectsAndKeys:
//        @"NSInteger", @"id",
////        @"NSString" , @"name",
////        @"NSString" , @"avatar",
////        @"NSInteger", @"type",
////        @"NSString" , @"source",
////        @"NSString" , @"sourceAccount",
//        @"NSString" , @"sourceNickname",nil]];
//    }
//    enum ColumnDataType enum_dataType;
//    enum_dataType = 1;
        [self attr_accessor:[NSArray arrayWithObjects:[[SimpleRecordColumn alloc] initWithParamers:@"name"
                                                                                              type:ColumnDataTypeString
                                                                                            isNull:NO
                                                                                              isPK:NO
                                                                                           default:Nil],
                                                      [[SimpleRecordColumn alloc] initWithParamers:@"type"
                                                                                              type:ColumnDataTypeInteger
                                                                                            isNull:YES
                                                                                              isPK:NO
                                                                                           default:Nil],
                                                      [[SimpleRecordColumn alloc] initWithParamers:@"source"
                                                                                              type:ColumnDataTypeString
                                                                                            isNull:YES
                                                                                              isPK:NO
                                                                                           default:Nil],
//                                                      [[SimpleRecordColumn alloc] initWithParamers:@"sourceAccount"
//                                                                                              type:ColumnDataTypeString
//                                                                                            isNull:YES
//                                                                                              isPK:NO
//                                                                                           default:Nil],
//                                                      [[SimpleRecordColumn alloc] initWithParamers:@"sourceNickname"
//                                                                                              type:ColumnDataTypeString
//                                                                                            isNull:YES
//                                                                                              isPK:NO
//                                                                                           default:Nil],
                                                      nil]];
    }
    return self;
}

- (NSString *)description {
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)coder {

}

- (id)initWithCoder:(NSCoder *)coder {
    return nil;
}

@end
