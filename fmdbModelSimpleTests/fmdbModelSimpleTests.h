//
//  fmdbModelSimpleTests.h
//  fmdbModelSimpleTests
//
//  Created by skywalker on 13-5-4.
//  Copyright (c) 2013年 skywalker. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "SimpleRecord.h"
#import "FMSBook.h"


@class FMSBook;

@interface fmdbModelSimpleTests : SenTestCase

@property (nonatomic, strong) FMSBook *book;
- (void)testCreateTable;
- (void)testDropTable;
- (void)testSave;
- (void)testUpdate;
- (void)testFindByUID;

@end
