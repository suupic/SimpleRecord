//
// Created by skywalker on 13-5-11.
// Copyright (c) 2013 skywalker. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SimpleRecord.h"

@implementation SimpleRecord {

}
@synthesize db;

- (id)init {
    if (self = [super init]) {
        [self establishConnection];
    }
    return self;
}

+ (SimpleRecord *)shared {
    static SimpleRecord *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (BOOL)establishConnection{
    if(!dbPath){
        NSLog(@"dbPath MUST be set.");
        return NO;
    } else {
        self.db = [FMDatabase databaseWithPath:dbPath];
        if(![self.db open]){
            NSLog(@"Failed to establish connection to %@", dbPath);
        } else {
            NSLog(@"Connection established to %@", dbPath);
        }

        self.db.logsErrors = YES;
        return YES;
    }
}

+ (void) use:(NSString *)dataFileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    dbPath = [documentDirectory stringByAppendingPathComponent:dataFileName];
}

@end