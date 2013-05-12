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
    book.sourceAccount = @"sk@gmail.com";
//    book.authorId = [NSNumber numberWithInt:5];
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

- (void)testColumnInitWithParameters{
    NSArray *ar = [NSArray arrayWithObjects:[[SimpleRecordColumn alloc] initWithParamers:@"id"
                                                                                           type:ColumnDataTypeInteger
                                                                                         isNull:NO
                                                                                           isPK:NO
                                                                                        default:Nil],
                                                   [[SimpleRecordColumn alloc] initWithParamers:@"name"
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
//                                                   [[SimpleRecordColumn alloc] initWithParamers:@"source_account"
//                                                                                           type:ColumnDataTypeString
//                                                                                         isNull:YES
//                                                                                           isPK:NO
//                                                                                        default:Nil],
//                                                   [[SimpleRecordColumn alloc] initWithParamers:@"source_nickname"
//                                                                                           type:ColumnDataTypeString
//                                                                                         isNull:YES
//                                                                                           isPK:NO
//                                                                                        default:Nil],
                                                   nil ];
    SimpleRecordColumn *column1 = [ar objectAtIndex:0];
    STAssertEqualObjects(column1.name, @"id", [column1 description], nil);
    SimpleRecordColumn *column4 = [ar objectAtIndex:3];
    STAssertEqualObjects(column4.name, @"source", [column4 description], nil);
}

- (void)testColumntoCreateSQLPart{
    SimpleRecordColumn *column = [[SimpleRecordColumn alloc] initWithParamers:@"id"
                                                                        type:ColumnDataTypeInteger
                                                                      isNull:NO
                                                                        isPK:YES
                                                                     default:Nil];
    NSString *columnString = column.toCreateSQLPart;
    NSString *expectString = @"id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ";
    STAssertTrue([columnString isEqualToString:expectString], columnString, Nil);
}
@end
