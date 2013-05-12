//
//  fmdbModelSimpleTests.m
//  fmdbModelSimpleTests
//
//  Created by skywalker on 13-5-4.
//  Copyright (c) 2013年 skywalker. All rights reserved.
//

#import "fmdbModelSimpleTests.h"

@implementation fmdbModelSimpleTests
@synthesize book;

- (void)setUp
{
    [super setUp];

    // Set-up code here.

    [SimpleRecord use:@"simpleRecordTesting.db"];
    book = [[FMSBook alloc] init];
    [FMSBook createTable];
    book.name = @"testbook12";
    book.authorId = [NSNumber numberWithInt:5];
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
    [FMSBook dropTable];
}

- (void)testSimpleRecordShared{
    STAssertFalse(![SimpleRecord shared], [SimpleRecord shared].description);
}

- (void)testSimpleRecordSharedDBGoodConnection{
    db = [[SimpleRecord shared] db];
    STAssertTrue(db.goodConnection, Nil);
}

- (void)testSave {
    BOOL boolResult = book.save;
    STAssertTrue(boolResult, nil);
}

- (void)testCreateTable {
    [FMSBook dropTable];
    STAssertTrue([FMSBook createTable], nil);
}

- (void)testDropTable {
    STAssertTrue([FMSBook dropTable], nil);
}

- (void)testUpdate {

}

- (void)testFindByUID {

}

- (void)testFindOne {
    book.name=@"hello";
    book.save;
    FMResultSet *rs = [FMSBook findOne];
    NSString *name = @"";
    if([rs next]){
        name = [rs stringForColumn:@"name"];
    }
    STAssertTrue([name isEqualToString:book.name], name.description);
}

@end
