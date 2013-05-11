//
//  fmdbModelSimpleTests.m
//  fmdbModelSimpleTests
//
//  Created by skywalker on 13-5-4.
//  Copyright (c) 2013年 skywalker. All rights reserved.
//

#import "fmdbModelSimpleTests.h"
#import "FMSBook.h"

@implementation fmdbModelSimpleTests
@synthesize book;

- (void)setUp
{
    [super setUp];

    book = [[FMSBook alloc] init];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in fmdbModelSimpleTests");
}

- (void)testSave {
    book.name = @"testbook12";
    book.authorId = [NSNumber numberWithInt:5];
    STAssertTrue(book.save, @"cannot be save.", nil);
}

- (void)testCreateTable {
    STAssertTrue([FMSBook createTable], @"must success.", nil);
}

- (void)testDropTable {
//  [FMSBook dropTable];
}

- (void)testSave {

}

- (void)testUpdate {

}

- (void)testFindByUID {

}

@end
