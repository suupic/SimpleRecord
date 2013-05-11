//
//  FMSBook.m
//  fmdbModelSimple
//
//  Created by skywalker on 13-5-4.
//  Copyright (c) 2013年 skywalker. All rights reserved.
//

#import "FMSBook.h"

@implementation FMSBook

@synthesize uid;
@synthesize name;
@synthesize authorId;

- (id)init {
    if (self = [super init]) {
        [self attr_accessor:[NSDictionary dictionaryWithObjectsAndKeys:
        @"NSString" , @"name",
        @"NSInteger" , @"authorId", nil]];
    }
    enum ColumnDataType enum_dataType;
    enum_dataType = 1;
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
